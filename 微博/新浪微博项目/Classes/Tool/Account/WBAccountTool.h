//
//  WBAccountTool.h
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAccount.h"

@interface WBAccountTool : NSObject

///存储账户
+ (void)saveAccount:(WBAccount *)account;

///取账户
+ (WBAccount *)account;

///用户授权
+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)())failure;

@end
