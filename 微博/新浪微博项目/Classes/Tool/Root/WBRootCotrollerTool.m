//
//  WBRootCotrollerTool.m
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBRootCotrollerTool.h"
#import "WBTabController.h"
#import "WBNewFetureController.h"

#define WBVersionKey @"version"
@implementation WBRootCotrollerTool

///选择根控制器
+ (void)chooseRootCotroller:(UIWindow *)window
{
    //获取当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    NSString *lastVerson = [[NSUserDefaults standardUserDefaults] objectForKey:WBVersionKey];
    
    //如果有新版本就显示新特性界面
    if ([currentVersion isEqualToString:lastVerson]) {
        
        //创建tabar
        WBTabController *tabC = [[WBTabController alloc] init];
        //设置为window的根控制器
        window.rootViewController = tabC;
    }else{
        WBNewFetureController *newC = [[WBNewFetureController alloc] init];
        window.rootViewController = newC;
        
        //保存当前版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:WBVersionKey];
    }
}

@end
