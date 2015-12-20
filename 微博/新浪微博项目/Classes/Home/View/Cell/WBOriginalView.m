//
//  WBOriginalView.m
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBOriginalView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "WBPhotosView.h"

@interface WBOriginalView ()

///头像
@property (nonatomic,weak) UIImageView *iconView;
///昵称
@property (nonatomic,weak) UILabel *nameLabel;
///vip
@property (nonatomic,weak) UIImageView *vipView;
///时间
@property (nonatomic,weak) UILabel *timeLabel;
///来源
@property (nonatomic,weak) UILabel *sourceLabel;
///正文
@property (nonatomic,weak) UILabel *textLabel;
///配图
@property (nonatomic,weak) WBPhotosView *photosView;

@end

@implementation WBOriginalView

- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //设置位置
    [self setUpFrame];
    
    //设置数据
    [self setUpData];
}

//设置子控件位置
- (void)setUpFrame
{
    //头像
    _iconView.frame = _statusFrame.originalIconFrame;
    //昵称
    _nameLabel.frame = _statusFrame.originalNameFrame;
    //vip
    if (_statusFrame.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusFrame.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }

    //由于cell重用的原因，这两个的frame设置要每次都更新
    //时间
    CGFloat timeX = _nameLabel.x;
    CGFloat timeY = CGRectGetMaxY(_statusFrame.originalNameFrame) + WBStatusCellMargin * 0.5;
    CGSize timeSize = [_statusFrame.status.created_at sizeWithFont:WBTimeFont];
    _timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + WBStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_statusFrame.status.source sizeWithFont:WBSourceFont];
    _sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};

    //正文
    _textLabel.frame = _statusFrame.originalTextFrame;
    
    //配图
    _photosView.frame = _statusFrame.originalPhotoFrame;
    
}
//设置子控件的数据
- (void)setUpData
{
    WBStatus *status = _statusFrame.status;
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //昵称
    _nameLabel.text = status.user.name;
    if (status.user.vip) {
        _nameLabel.textColor = [UIColor redColor];
    }else{
        _nameLabel.textColor = [UIColor blackColor];
    }
    
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    //时间
    _timeLabel.text = status.created_at;
    //来源
    _sourceLabel.text = status.source;
    //正文
    _textLabel.text = status.text;
    //配图
    _photosView.pic_urls = status.pic_urls;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
        
        //设置原创微博的子控件
        [self setUpChildView];
        
    }
    return self;
}

//设置原创微博的子控件
- (void)setUpChildView
{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = WBNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    //vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = WBTimeFont;
    timeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    //来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = WBSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
    //正文
    UILabel *textLabel = [[UILabel alloc] init];
    
    textLabel.numberOfLines = 0;
    textLabel.font = WBTextFont;
    
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    //配图
    WBPhotosView *photosView = [[WBPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}


@end
