//
//  WBCommentResult.h
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WBCommentResult : NSObject <MJKeyValue>

///评论数组
@property (nonatomic,strong) NSArray *comments;

@end
