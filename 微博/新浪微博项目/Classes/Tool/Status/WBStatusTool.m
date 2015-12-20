//
//  WBStatusTool.m
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBAccountTool.h"
#import "WBHttpTool.h"
#import "WBStatus.h"
#import "WBStatusParam.h"
#import "WBStatusResult.h"

@implementation WBStatusTool

//获得新的微博数据
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure
{
    
    //创建参数模型
    WBStatusParam *param = [[WBStatusParam alloc] init];
    
    //如果sinceId有值才传
    if (sinceId) {
        param.since_id = sinceId;
    }
    param.access_token = [WBAccountTool account].access_token;
    
    //请求数据
    //模型转字典作为参数
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
               
        //把结果字典转换成结果模型
        WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
        
        //成功回调block 把转好的对象传出去
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        
        //失败调用block
        if (failure) {
            failure(error);
        }
    }];
}

//获得更多的微博数据
///更多的微博数据
+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure
{
  
    //创建参数模型
    WBStatusParam *param = [[WBStatusParam alloc] init];
    
    //如果sinceId有值才传
    if (maxId) {
        param.max_id = maxId;
    }
    param.access_token = [WBAccountTool account].access_token;
    
    //请求数据
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        //把结果字典转换成结果模型
        WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
        
        //成功回调block 把转好的对象传出去
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        
        //失败调用block
        if (failure) {
            failure(error);
        }
    }];
}


@end
