//
//  WBBaseParam.m
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBBaseParam.h"
#import "WBAccountTool.h"

@implementation WBBaseParam

//返回一个已经赋值好access_token的实例对象s
+ (instancetype)param
{
    WBBaseParam *param = [[self alloc] init];
    
    param.access_token = [WBAccountTool account].access_token;
    
    return param;
}

@end
