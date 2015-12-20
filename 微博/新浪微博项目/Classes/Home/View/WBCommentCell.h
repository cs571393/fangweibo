//
//  WBCommentCellTableViewCell.h
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBComment;
@interface WBCommentCell : UITableViewCell

@property (nonatomic,strong) WBComment *comment;

@end
