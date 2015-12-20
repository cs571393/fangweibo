//
//  WBStatusResult.m
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBStatusResult.h"
#import "WBStatus.h"

@implementation WBStatusResult

+ (NSDictionary *)objectClassInArray
{
    //把statuses数组里的元素转成WBStatus模型
    return @{@"statuses":[WBStatus class]};
}

@end
