//
//  WBAccount.h
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>

///用于调用access_token，接口获取授权后的access token。
@property (nonatomic,copy) NSString *access_token;
///access_token的生命周期，单位是秒数。
@property (nonatomic,copy) NSString *expires_in;
///access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
@property (nonatomic,copy) NSString *remind_in;
///当前授权用户的UID。
@property (nonatomic,copy) NSString *uid;

///过期时间
@property (nonatomic,strong) NSDate *expires_date;

///用户名
@property (nonatomic,copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
