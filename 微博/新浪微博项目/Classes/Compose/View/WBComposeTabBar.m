//
//  WBComposeTabBar.m
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBComposeTabBar.h"

@implementation WBComposeTabBar

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置所有的子控件
        [self setUpAllChildView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = 35;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

//设置所有的子控件
- (void)setUpAllChildView
{
    //图片
    [self buttonWithNorImage:[UIImage imageNamed:@"compose_toolbar_picture"] HighImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
    
    //@
    [self buttonWithNorImage:[UIImage imageNamed:@"compose_mentionbutton_background"] HighImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    
    //话题
    [self buttonWithNorImage:[UIImage imageNamed:@"compose_trendbutton_background"] HighImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    
    //表情
    [self buttonWithNorImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] HighImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    
    //键盘
    [self buttonWithNorImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] HighImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
}

//设置一个子控件
- (void)buttonWithNorImage:(UIImage *)norImage HighImage:(UIImage *)highImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:norImage forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    btn.tag = self.subviews.count;
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeTabBar:didClickBtnWithTag:)]) {
        [self.delegate composeTabBar:self didClickBtnWithTag:btn.tag];
    }
}

@end
