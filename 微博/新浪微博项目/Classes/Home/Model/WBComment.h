//
//  WBComment.h
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUser,WBComment;
@interface WBComment : NSObject

///评论创建时间
@property (nonatomic,copy) NSString *created_at;

///评论的内容
@property (nonatomic,copy) NSString *text;

///评论的作者
@property (nonatomic,strong) WBUser *user;

///评论id
@property (nonatomic,copy) NSString *idstr;

///评论来源评论，当本评论属于对另一评论的回复时返回此字段
@property (nonatomic,strong) WBComment *reply_comment;

@end
