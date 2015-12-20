//
//  WBShowCommentViewController.m
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBShowCommentViewController.h"
#import "WBCommentTool.h"
#import "WBComment.h"

#import "WBCommentViewController.h"
#import "WBCommentCell.h"

#import "MJRefresh.h"

@interface WBShowCommentViewController ()

///评论数组
@property (nonatomic,strong) NSMutableArray *comments;

@end

@implementation WBShowCommentViewController

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(comment)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //请求所有评论
    [self requestComments];
    
    //添加顶部刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewComments)];
    //添加底部刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreComments)];
    
}

#pragma mark - 加载更多评论
- (void)loadNewComments
{
    NSString *sincId = nil;
    if (self.comments.count) {
        sincId = [self.comments[0] idstr];
    }
    //请求新数据
    [WBCommentTool commentWithId:self.idStr SinceId:sincId success:^(NSArray *comments) {
        //结束刷新
        [self.tableView headerEndRefreshing];
        
        //把请求的到数据插入到数据前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, comments.count)];
        [self.comments insertObjects:comments atIndexes:indexSet];
        //刷新表格
        [self.tableView reloadData];

        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadMoreComments
{
    NSString *maxId = nil;
    if (self.comments.count) {
        long long max = [[self.comments lastObject] idstr].longLongValue - 1;
        maxId = [NSString stringWithFormat:@"%lld",max];
    }
    //请求之前的数据
    [WBCommentTool commentWithId:self.idStr MaxId:maxId success:^(NSArray *comments) {
        //结束刷新
        [self.tableView footerEndRefreshing];
        //添加到数组后面
        [self.comments addObjectsFromArray:comments];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 评论
- (void)comment
{
    WBCommentViewController *commentVC = [[WBCommentViewController alloc] init];
    commentVC.idStr = self.idStr;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 请求评论
- (void)requestComments
{
    [WBCommentTool commentWithId:self.idStr SinceId:nil success:^(NSArray *comments) {
        
        [self.comments addObjectsFromArray:comments];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        
    }];
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"commentCell";
    WBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    WBComment *comment = self.comments[indexPath.row];
    
    cell.comment = comment;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



@end
