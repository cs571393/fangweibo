//
//  WBStatus.h
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WBUser.h"
#import "MJExtension.h"

/*
 created_at	string	微博创建时间
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 user	object	微博作者的用户信息字段
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 pic_urls	object	微博配图数组
 
 */
@interface WBStatus : NSObject <MJKeyValue>

///转发微博
@property (nonatomic,strong) WBStatus *retweeted_status;
///转发微博的博主名
@property (nonatomic,copy) NSString *retweetedName;

///用户
@property (nonatomic,strong) WBUser *user;
///微博创建时间
@property (nonatomic,copy) NSString *created_at;
///字符串型的微博ID
@property (nonatomic,copy) NSString *idstr;
///微博信息内容
@property (nonatomic,copy) NSString *text;
///微博来源
@property (nonatomic,copy) NSString *source;
///转发数
@property (nonatomic,assign) int reposts_count;
///评论数
@property (nonatomic,assign) int comments_count;
///表态数
@property (nonatomic,assign) int attitudes_count;
///配图数组
@property (nonatomic,strong) NSArray *pic_urls;



@end
