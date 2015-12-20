//
//  WBTitleButton.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBTitleButton.h"

@implementation WBTitleButton

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        return;
    }
    
    //title
    self.titleLabel.x = 0;
    
    //imageView
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

//重写setter方法。重新计算文字和图片的大小
- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
