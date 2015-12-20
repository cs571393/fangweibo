//
//  WBAccount.m
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBAccount.h"
#import "MJExtension.h"

#define WBAccess_tokenKey @"access_token"
#define WBExpires_inKey @"expires_in"
#define WBUidKey @"uid"
#define WBExpires_dateKey @"expires_date"

@implementation WBAccount

//MJ归档解档 底层遍历每个属性，一个个归档解档
MJCodingImplementation

//重写_expires_in来确定过期时间
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:_expires_in.longLongValue];
}

//归档时调用
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:WBAccess_tokenKey];
//    [aCoder encodeObject:_expires_in forKey:WBExpires_inKey];
//    [aCoder encodeObject:_uid forKey:WBUidKey];
//    [aCoder encodeObject:_expires_date forKey:WBExpires_dateKey];
//}
//解档时调用
//- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        _access_token = [aDecoder decodeObjectForKey:WBAccess_tokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:WBExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:WBUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:WBExpires_dateKey];
//    }
//    return self;
//}

/*
 kvc的底层原理是使用枚举器来遍历key
 
 1.查找setKey方法 例如setUid... 找到就直接调用赋值
 2.寻找_key赋值，例如_uid 如果有就直接赋值
 3.寻找与key同名的属性，有旧直接赋值
 4.都没有找到就报错了
 
 */

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    WBAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

@end
