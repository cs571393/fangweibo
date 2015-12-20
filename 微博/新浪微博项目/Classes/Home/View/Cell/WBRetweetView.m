//
//  WBRetweetView.m
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBRetweetView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBPhotosView.h"

@interface WBRetweetView ()

///昵称
@property (nonatomic,weak) UILabel *nameLabel;
///正文
@property (nonatomic,weak) UILabel *textLabel;
///配图
@property (nonatomic,weak) WBPhotosView *photosView;

@end

@implementation WBRetweetView

- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.userInteractionEnabled = YES;
    self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    
    //设置子控件位置
    [self setUpFrame];

    //设置子控件数据
    [self setUpData];
}

//设置子控件位置
- (void)setUpFrame
{
    //昵称
    _nameLabel.frame = _statusFrame.retweetNameFrame;

    //正文
    _textLabel.frame = _statusFrame.retweetTextFrame;
    
    //配图
    _photosView.frame = _statusFrame.retweetPhotoFrame;
    
}
//设置子控件的数据
- (void)setUpData
{
    WBStatus *status = _statusFrame.status;

    //昵称
    _nameLabel.text = status.retweetedName;
    //正文
    _textLabel.text = status.retweeted_status.text;
    //配图
    _photosView.pic_urls = status.retweeted_status.pic_urls;
    
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置原创微博的子控件
        [self setUpChildView];
        
    }
    return self;
}

//设置转发微博的子控件
- (void)setUpChildView
{
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = WBNameFont;
    nameLabel.textColor = [UIColor blueColor];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    //正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = WBTextFont;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    //配图
    WBPhotosView *photosView = [[WBPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}


@end
