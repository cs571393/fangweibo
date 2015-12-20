//
//  WBCommentParam.h
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBBaseParam.h"

@interface WBCommentParam : WBBaseParam

///评论内容
@property (nonatomic,copy) NSString *comment;


@property (nonatomic,copy) NSString *idStr;

@property (nonatomic,copy) NSString *since_id;

@property (nonatomic,copy) NSString *max_id;



@end
