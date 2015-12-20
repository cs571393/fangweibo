//
//  WBCommentTool.h
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBCommentTool : NSObject

///发表评论
+ (void)commentWithText:(NSString *)text idStr:(NSString *)idStr success:(void(^)())success failure:(void(^)(NSError *error))failure;

///获取最新评论
+ (void)commentWithId:(NSString *)idStr SinceId:(NSString *)sinceId success:(void(^)(NSArray *comments))success failure:(void(^)(NSError *error))failure;

///获取更多评论
+ (void)commentWithId:(NSString *)idStr MaxId:(NSString *)maxId success:(void(^)(NSArray *comments))success failure:(void(^)(NSError *error))failure;

@end
