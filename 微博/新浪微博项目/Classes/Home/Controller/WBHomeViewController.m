//
//  WBHomeViewController.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "WBTitleButton.h"
#import "WBPopMenu.h"

#import "WBCover.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "MJExtension.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "WBHttpTool.h"
#import "WBStatusTool.h"
#import "WBUserTool.h"
#import "WBStatusCell.h"
#import "WBStatusFrame.h"
#import "WBStatusToolBar.h"

#import "WBRetweetViewController.h"
#import "WBShowCommentViewController.h"



@interface WBHomeViewController () <WBCoverDelegate,WBStatusToolBarDelegate>


///标题按钮
@property (nonatomic,weak) WBTitleButton *titleBtn;

///微博视图模型数组
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation WBHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    [self setUpNavigationBar];
    
    //加载新微博
//    [self loadNewStatus];
    
    //添加顶部刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    //添加底部上啦空间
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    //请求用户信息
    [WBUserTool userInfoWithSuccess:^(WBUser *user) {
        
        //设置首页titleBtn的标题
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        //保存用户
        WBAccount *account = [WBAccountTool account];
        account.name = user.name;
        
        [WBAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - WBStatusToolBarDelegate 代理方法
- (void)statusToolBar:(WBStatusToolBar *)statusToolBar didClickedBtnWithTag:(NSInteger)tag idStr:(NSString *)idStr
{
    //根据不同的按钮做不同的事
    switch (tag) {
        case 0:
            //推出转发微博控制器
            [self retweetWithStatus:statusToolBar.status];
            break;
        case 1:
            //推出评论微博控制器
            [self commentWithId:idStr];
            break;
            
        default:
            break;
    }
    
}
#pragma mark - 工具栏的方法
//转发
- (void)retweetWithStatus:(WBStatus *)status
{
    WBRetweetViewController *retweetVC = [[WBRetweetViewController alloc] init];
    retweetVC.status = status;
    retweetVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:retweetVC animated:YES];
}

//评论
- (void)commentWithId:(NSString *)idStr
{
    WBShowCommentViewController *scVC = [[WBShowCommentViewController alloc] init];
    scVC.idStr = idStr;
    scVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scVC animated:YES];
}

#pragma mark - 请求数据
///刷新数据
- (void)refresh
{
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
}
///请求更多数据(旧)
- (void)loadMoreStatus
{
    
    NSString *maxId = nil;
    if (self.statusFrames.count) {
        //取出视图模型里的status模型
        WBStatus *status = [[self.statusFrames lastObject] status];
        
        long long max = [status idstr].longLongValue - 1;
        maxId = [NSString stringWithFormat:@"%lld",max];
    }
    
    //请求更多的数据
    [WBStatusTool moreStatusWithMaxId:maxId success:^(NSArray *statues) {
        
        //结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        //微博模型转微博视图模型
        NSMutableArray *statusFs = [NSMutableArray array];
        for (WBStatus *status in statues) {
            
            WBStatusFrame *statusF = [[WBStatusFrame alloc] init];
            statusF.status = status;
            [statusFs addObject:statusF];
        }
        
        
        //放到数组最后面
        [self.statusFrames addObjectsFromArray:statusFs];
        //刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
        
}

///请求新数据
- (void)loadNewStatus
{
    NSString *sincId = nil;
    if (self.statusFrames.count) {
        //存在微博数据，才需要下拉更新微博
        //第一个是最新的
        
        //取出微博模型
        WBStatus *status = [self.statusFrames[0] status];
        sincId = [status idstr];
    }
    
    //请求更新的数据
    [WBStatusTool newStatusWithSinceId:sincId success:^(NSArray *statues) {
        
        //显示新的微博数label
        [self showNewStatusesCount:(int)statues.count];
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        //模型转视图模型
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (WBStatus *status in statues) {
            
            WBStatusFrame *statusF = [[WBStatusFrame alloc] init];
            statusF.status = status;
            [tmpArray addObject:statusF];
        }
        
        
        //插入到数组最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statues.count)];
        [self.statusFrames insertObjects:tmpArray atIndexes:indexSet];
        //刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

///显示新的微博数label
- (void)showNewStatusesCount:(int)count
{
    //创建label
    CGFloat w = self.view.width;
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    //设置label的文字
    label.text = [NSString stringWithFormat:@"最新的微博数%d",count];
    //背景图片
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    //文字居中
    label.textAlignment = NSTextAlignmentCenter;
    //文字颜色
    label.textColor = [UIColor whiteColor];
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //下拉
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        
        //上拉
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            //移除label
            [label removeFromSuperview];
        }];
    
    }];
    
}

///设置导航条的内容
- (void)setUpNavigationBar
{
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    //titleView
    WBTitleButton *titleButton = [WBTitleButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn = titleButton;
    //设置属性
    
    //取出账户信息赋值
    NSString *title = [WBAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    //高亮的时候不调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    //监听事件
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.titleView = titleButton;
    
}

- (void)titleClick:(UIButton *)btn
{
    //改变按钮的状态
    btn.selected = !btn.selected;
    
    //弹出蒙版
    WBCover *cover = [WBCover show];
    cover.delegate = self;
    
    //弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    
    [WBPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    
}

#pragma mark - WBCoverDelegate
- (void)coverDidClickedCover:(WBCover *)cover
{
    //隐藏下拉菜单
    [WBPopMenu hide];
    
    //取消按钮选中状态
    self.titleBtn.selected = NO;
}

#pragma mark - 导航栏的点击事件
- (void)friendsearch
{
    NSLog(@"%s",__func__);
}
- (void)pop
{
    //都传nil默认会自己寻找xib
//    WBOneViewController *one = [[WBOneViewController alloc] initWithNibName:nil bundle:nil];
    
    /*
     创建one控制器
     1.首先会寻找有没有oneView.xib
     2.没有就会找oneViewController.xib
     3.默认创建几乎透明的view
     
     */
//    WBOneViewController *one = [[WBOneViewController alloc] init];
//    
//    //隐藏底部栏 只会隐藏系统的底部栏
//    one.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:one animated:YES];
}

//收到内存警告调用
- (void)didReceiveMemoryWarning
{
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    //清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //取出对应模型
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    //取出对应模型
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    cell.statusFrame = statusFrame;
    
    cell.toolBar.delegate = self;
    
    return cell;
}


@end
