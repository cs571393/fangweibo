//
//  WBBadgeView.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBBadgeView.h"

#define WBBadgeViewFont [UIFont systemFontOfSize:11]
@implementation WBBadgeView

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //取消用户交互
        self.userInteractionEnabled = NO;
        //设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        //button尺寸自适应
        [self sizeToFit];
        //设置字体大小
        self.titleLabel.font = WBBadgeViewFont;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    //判断是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        //隐藏
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    //获得当前字体的尺寸
    CGSize size = [badgeValue sizeWithFont:WBBadgeViewFont];
    
    //如果字符宽度大于控件的宽度，就显示一个圆点
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setImage:nil forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    }
}

@end
