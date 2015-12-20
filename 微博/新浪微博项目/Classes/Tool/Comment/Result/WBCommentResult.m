//
//  WBCommentResult.m
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBCommentResult.h"
#import "WBComment.h"

@implementation WBCommentResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"comments":[WBComment class]};
}

@end
