//
//  WBUserTool.m
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBUserTool.h"
#import "WBUserParam.h"
#import "WBUserResult.h"
#import "WBHttpTool.h"
#import "WBAccountTool.h"
#import "MJExtension.h"
#import "WBUser.h"

@implementation WBUserTool

///请求未读信息
+ (void)unreadWithSuccess:(void(^)(WBUserResult *result))success failure:(void(^)(NSError *error))failure;
{
    //创建参数模型
    WBUserParam *param = [WBUserParam param];
    
    param.uid = [WBAccountTool account].uid;
    
    //网络请求
    [WBHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转模型
        WBUserResult *result = [WBUserResult objectWithKeyValues:responseObject];
        
        //回调
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

///请求用户信息
+ (void)userInfoWithSuccess:(void(^)(WBUser *user))success failure:(void(^)(NSError *error))failure
{
    //1.创建参数模型
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    //2.发送GET请求
    [WBHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转模型
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
