//
//  WBCommentCellTableViewCell.m
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBCommentCell.h"
#import "WBUser.h"
#import "WBComment.h"
#import "UIImageView+WebCache.h"

@interface WBCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation WBCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"WBCommentCell" owner:nil options:nil]lastObject];
        
        //设置子控件
        [self setUpChildeView];
    }
    return self;
}

- (void)setUpChildeView
{
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.height / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
}


- (void)setComment:(WBComment *)comment
{
    _comment = comment;
    
    self.nameLabel.text = comment.user.name;
    [self.iconView sd_setImageWithURL:comment.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.contentLabel.text = comment.text;
    self.timeLabel.text = comment.created_at;
}

@end
