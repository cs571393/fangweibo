//
//  AppDelegate.m
//  新浪微博项目
//
//  Created by neng on 15/9/28.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabController.h"
#import "WBNewFetureController.h"
#import "WBOAuthViewController.h"
#import "WBAccountTool.h"
#import "WBRootCotrollerTool.h"
#import <AVFoundation/AVFoundation.h>


@interface AppDelegate ()

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //真机上后台播放音乐需要设置会话
    AVAudioSession *session = [[AVAudioSession alloc] init];
    //设置会话类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活
    [session setActive:YES error:nil];
    
    //注册通知数
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //判断有没有授权
    if ([WBAccountTool account]) {
        //选择根控制器
        [WBRootCotrollerTool chooseRootCotroller:self.window];

    }else{
        //授权页面
        WBOAuthViewController *oAuthVC = [[WBOAuthViewController alloc] init];
        self.window.rootViewController = oAuthVC;
    }
    
    //显示window并且成为主窗口
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


//程序失去焦点时调用
- (void)applicationWillResignActive:(nonnull UIApplication *)application
{
    //播放音乐
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player = player;
    
    //无限循环
    player.numberOfLoops = -1;
    
    [player prepareToPlay];
    
    [player play];
}

//程序进入后台调用哪个
- (void)applicationDidEnterBackground:(nonnull UIApplication *)application
{
    //开启一个后台任务  然后通过让苹果以为这个程序在后台播放静音音乐来提高优先级，减少程序被杀死的可能
    UIBackgroundTaskIdentifier *ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        //后台任务结束时调用
        [application endBackgroundTask:ID];
        
    }];
}


@end
