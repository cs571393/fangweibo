//
//  WBAccountTool.m
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBHttpTool.h"
#import "WBAccountParam.h"
#import "MJExtension.h"

#define WBAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#define WBBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define WBClient_id @"697062942"
#define WBRedirect_uri @"http://www.baidu.com"
#define WBClient_secret @"971abc4b59c8a22d124b132866d0920e"

@implementation WBAccountTool

//类方法一般使用静态变量代替成员属性
static WBAccount *_account;

//保存用户信息
+ (void)saveAccount:(WBAccount *)account
{
    //保存用户的信息
    NSString *fileName = WBAccountFileName;
    //归档
    [NSKeyedArchiver archiveRootObject:account toFile:fileName];
}

//取出用户信息
+ (WBAccount *)account
{
    //相当于懒加载
    if (_account == nil) {
         _account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccountFileName];
        
        //判断授权是否过期
        //如果不是升序就是过期了
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    
    return _account;
}

//用户授权
+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)())failure
{
    //创建参数模型
    WBAccountParam *param = [[WBAccountParam alloc] init];
    
    param.client_id = WBClient_id;
    param.client_secret = WBClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = WBRedirect_uri;
    
    [WBHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转模型
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        
        //保存用户信息
        [WBAccountTool saveAccount:account];
        
        //调用成功回调block
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        
        //调用失败回调block
        if (failure) {
            failure();
        }
    }];
    
}

//删除账户
+ (void)deleteAccount
{
    _account.expires_date = [NSDate date];
}

@end
