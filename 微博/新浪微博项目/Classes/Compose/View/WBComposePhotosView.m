//
//  WBComposePhotosView.m
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

//每次设置图片都创建一个控件
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width - (cols - 1) *margin) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIImageView *imageView = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        
        imageView.frame = CGRectMake(x, y, wh, wh);
        
    }
}

@end
