//
//  WBNavigationController.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface WBNavigationController () <UINavigationControllerDelegate>

///保存滑动手势的代理
@property (nonatomic,strong) id popDelegate;

@end

@implementation WBNavigationController

+ (void)initialize
{
    //获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    //设置字体颜色
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    self.delegate = self;
    
    //保存代理
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    
}

//tabBarButton重复显示bug解决 在此方法移除
- (void)navigationController:(nonnull UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    //获得根控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITabBarController *tabVC = (UITabBarController *)window.rootViewController;
    
    //遍历tabBar的子控件
    for (UIView *view in tabVC.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

//导航控制器跳转完成调用
- (void)navigationController:(nonnull UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    //如果是根控制器。就还原滑动手势代理
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        //清空滑动返回手势的代理，就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    //设置非根控制器的导航条的内容
    //一开始控制器的数量为0，push根控制器的时候后count为0，不为0的情况是在push非根控制器
    if (self.viewControllers.count != 0) {
        
        //设置左边和右边的按钮
        //如果把系统的返回按钮覆盖了，滑动返回的功能就没有了
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 导航条左边右边按钮的点击事件
- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
