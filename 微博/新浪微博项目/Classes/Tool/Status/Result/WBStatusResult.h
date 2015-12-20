//
//  WBStatusResult.h
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WBStatusResult : NSObject <MJKeyValue>

///微博数组
@property (nonatomic,strong) NSArray *statuses;
///微博总数
@property (nonatomic,assign) int total_count;

@end
