//
//  WBBaseParam.h
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseParam : NSObject

@property (nonatomic,copy) NSString *access_token;

///创建一个已经赋值了access_token的参数模型
+ (instancetype)param;

@end
