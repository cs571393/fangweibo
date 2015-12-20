//
//  WBCommentTool.m
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBCommentTool.h"
#import "WBCommentParam.h"
#import "MJExtension.h"
#import "WBHttpTool.h"
#import "WBCommentResult.h"

@implementation WBCommentTool

+(void)commentWithId:(NSString *)idStr MaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    WBCommentParam *param = [WBCommentParam param];
    param.max_id = maxId;
    
    NSMutableDictionary *paramDict = param.keyValues;
    paramDict[@"id"] = idStr;
    
    [WBHttpTool GET:@"https://api.weibo.com/2/comments/show.json" parameters:paramDict success:^(id responseObject) {
        
        WBCommentResult *result = [WBCommentResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.comments);
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+(void)commentWithId:(NSString *)idStr SinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    WBCommentParam *param = [WBCommentParam param];
    param.since_id = sinceId;
    
    NSMutableDictionary *paramDict = param.keyValues;
    paramDict[@"id"] = idStr;
    
    [WBHttpTool GET:@"https://api.weibo.com/2/comments/show.json" parameters:paramDict success:^(id responseObject) {
        
        WBCommentResult *result = [WBCommentResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.comments);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+(void)commentWithText:(NSString *)text idStr:(NSString *)idStr success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    WBCommentParam *param = [WBCommentParam param];
    param.comment = text;
    
    NSMutableDictionary *paramDict = param.keyValues;
    paramDict[@"id"] = idStr;
    
    //发送请求
    [WBHttpTool POST:@"https://api.weibo.com/2/comments/create.json" parameters:paramDict success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
