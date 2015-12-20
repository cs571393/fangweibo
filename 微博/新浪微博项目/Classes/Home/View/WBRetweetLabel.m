//
//  WBRetweetLabel.m
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBRetweetLabel.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"

@interface WBRetweetLabel ()

//头像
@property (nonatomic,weak) UIImageView *iconView;
//昵称
@property (nonatomic,weak) UILabel *nameLabel;
//文字
@property (nonatomic,weak) UILabel *textLabel;

@end

@implementation WBRetweetLabel

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    [self.iconView sd_setImageWithURL:status.user.profile_image_url];
    self.nameLabel.text = status.user.name;
    self.textLabel.text = status.text;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        
        [self setUpChildViews];
    }
    return self;
}

- (void)setUpChildViews
{
    //创建子控件
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:13];
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    self.textLabel = textLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //头像
    CGFloat iconH = 50;
    CGFloat iconW = iconH;
    CGFloat iconX = 10;
    CGFloat iconY = (self.bounds.size.height - iconH) / 2;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGSize nameSize = [self.nameLabel.text sizeWithFont:[UIFont systemFontOfSize:15]];
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat nameY = iconY;
    self.nameLabel.frame = (CGRect){{nameX,nameY},nameSize};
    
    //文字
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameLabel.frame) + 5;
    CGFloat textH = 70 - textY - 10;
    CGFloat textW = self.bounds.size.width - textX;
    self.textLabel.frame = CGRectMake(textX, textY, textW, textH);
}

@end
