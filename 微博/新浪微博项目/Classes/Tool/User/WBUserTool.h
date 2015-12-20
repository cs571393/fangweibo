//
//  WBUserTool.h
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUserResult,WBUser;

@interface WBUserTool : NSObject

///请求未读信息
+ (void)unreadWithSuccess:(void(^)(WBUserResult *result))success failure:(void(^)(NSError *error))failure;

///请求用户信息
+ (void)userInfoWithSuccess:(void(^)(WBUser *user))success failure:(void(^)(NSError *error))failure;

@end
