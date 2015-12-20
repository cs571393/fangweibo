//
//  WBRetweetTool.m
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBRetweetTool.h"
#import "WBRetweetParam.h"
#import "MJExtension.h"
#import "WBHttpTool.h"

@implementation WBRetweetTool

+ (void)retweetWithText:(NSString *)text idStr:(NSString *)idStr success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建参数
    WBRetweetParam *param = [WBRetweetParam param];
    if (text) {
        param.status = text;
    }
    
    NSMutableDictionary *paramDict = param.keyValues;
    paramDict[@"id"] = idStr;
    
    [WBHttpTool POST:@"https://api.weibo.com/2/statuses/repost.json" parameters:paramDict success:^(id responseObject) {
        
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
