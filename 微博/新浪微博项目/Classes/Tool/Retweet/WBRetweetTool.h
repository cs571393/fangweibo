//
//  WBRetweetTool.h
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBRetweetTool : NSObject

+ (void)retweetWithText:(NSString *)text idStr:(NSString *)idStr success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
