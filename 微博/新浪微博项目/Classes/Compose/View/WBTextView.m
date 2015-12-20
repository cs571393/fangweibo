//
//  WBTextView.m
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView ()

//占位label
@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation WBTextView

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderLabel.font = self.font;
    }
    return self;
}

- (void)setHidePlaceholder:(BOOL)hidePlaceholder
{
    _hidePlaceholder = hidePlaceholder;
    
    _placeholderLabel.hidden = hidePlaceholder;
}

//每次设置字体大小都保证占位图片的文字的大小相等
- (void)setFont:(UIFont * __nullable)font
{
    //因为是私有api 写不出_font这样的属性
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    //如果先设置了占位文字再设置文字大小，原本已经算好的尺寸就有可能放不下了，最好在设置完文字大小后再算一次尺寸
    [self.placeholderLabel sizeToFit];
}

//懒加载占位label
- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil) {
        
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    
    return _placeholderLabel;
}


- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    //设置占位图的尺寸
    [self.placeholderLabel sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
}

@end
