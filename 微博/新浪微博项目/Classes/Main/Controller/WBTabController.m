//
//  WBTabController.m
//  新浪微博项目
//
//  Created by neng on 15/9/28.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBTabController.h"
#import "UIImage+Image.h"
#import "WBTabBar.h"
#import "WBDiscoverViewController.h"
#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBProfileViewController.h"
#import "WBNavigationController.h"
#import "WBUserTool.h"
#import "WBUserResult.h"
#import "WBComposeViewController.h"

@interface WBTabController () <WBTabBarDelegate>

///保存控制器的tabBarItem
@property (nonatomic,strong) NSMutableArray *items;

///首页控制器
@property (nonatomic,weak) WBHomeViewController *home;
///消息控制器
@property (nonatomic,weak) WBMessageViewController *message;
///我控制器
@property (nonatomic,weak) WBProfileViewController *profile;

@end

@implementation WBTabController

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

//一使用类的时候就调用
+ (void)initialize
{
    //获得所有的UITabBarItem外观标示   UIAppearance,所有遵守了UIAppearance协议的类都有此方法
//    UITabBarItem *item = [UITabBarItem appearance];
    
    //获得本类中的所有的UITabBarItem外观标示
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //如果要修改模型的文字颜色，只能通过富文本属性
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

//UITabBarController的View在已加载就会加载view,UIViewController的View才是懒加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加tabBar控制器子控制器
    [self setUpAllChildControllers];
    
    //设置tabBar
    [self setUpTabBar];
    
    //设置定时器定时请求未读信息
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}

///请求未读信息
- (void)requestUnread
{

    //请求微博的未读数
    [WBUserTool unreadWithSuccess:^(WBUserResult *result) {
        
        //设置未读数
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        //设置应用程序的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        
        
    }];
}

#pragma mark - WBTabBarDelegate
//点击加号按钮调用
- (void)tabBarDidClickPlusBtn:(WBTabBar *)tabBar
{
    //创建发布微博控制器
    WBComposeViewController *composeVC = [[WBComposeViewController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:composeVC];
    
    //模态推出控制器
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)tabBar:(WBTabBar *)tabBar didClickBtnWith:(NSInteger)tag
{
    //如果当前在首页并且点击首页按钮就刷新
    if (self.selectedIndex == tag && tag == 0) {
        [self.home refresh];
    }
    
    //跳转页面
    self.selectedIndex = tag;
}

#pragma mark - 设置tabBar
///设置tabBar
- (void)setUpTabBar
{
    //创建自定义的tabBar
    WBTabBar *tabBar = [[WBTabBar alloc] initWithFrame:self.tabBar.bounds];
    //设置背景颜色
    tabBar.backgroundColor = [UIColor whiteColor];
    
    //把保存好的items赋值给tabBar 在setter里面完成创建tabBarButton
    tabBar.items = self.items;
    
    //设置代理
    tabBar.delegate = self;
    
    //添加到tabBar上去
    [self.tabBar addSubview:tabBar];
    
}

//移除系统的tabBarButton
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

#pragma mark - 设置子控制器
///添加所有的子控制器
- (void)setUpAllChildControllers
{
    //首页
    WBHomeViewController *homeVC = [[WBHomeViewController alloc] init];
    [self setUpChildController:homeVC imageName:@"tabbar_home" selImageName:@"tabbar_home_selected" title:@"首页"];
    _home = homeVC;
    
    //消息
    WBMessageViewController *messageVC = [[WBMessageViewController alloc] init];
    [self setUpChildController:messageVC imageName:@"tabbar_message_center" selImageName:@"tabbar_message_center_selected" title:@"消息"];
    _message = messageVC;
    
    //发现
    WBDiscoverViewController *discoverVC = [[WBDiscoverViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setUpChildController:discoverVC imageName:@"tabbar_discover" selImageName:@"tabbar_discover_selected" title:@"发现"];
    
    //我
    WBProfileViewController *profileVC = [[WBProfileViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setUpChildController:profileVC imageName:@"tabbar_profile" selImageName:@"tabbar_profile_selected" title:@"我"];
    _profile = profileVC;
}

///添加一个自控制器
- (void)setUpChildController:(UIViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImgName title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageWithOriginal:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageWithOriginal:selImgName];
    
    //添加到items
    [self.items addObject:vc.tabBarItem];
    
    //创建导航控制器
    //底层调用Push方法来把控制器压入栈中
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
