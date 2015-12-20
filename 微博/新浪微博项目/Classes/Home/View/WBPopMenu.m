//
//  WBPopMenu.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBPopMenu.h"

@implementation WBPopMenu

//隐藏
+ (void)hide
{
    //遍历窗口的子控件
    for (UIView *view in WBKeyWindow.subviews) {
        if ([view isKindOfClass:self]) {
            //移除
            [view removeFromSuperview];
        }
    }
}

//弹出菜单
+ (instancetype)showInRect:(CGRect)rect
{
    WBPopMenu *menu = [[WBPopMenu alloc] initWithFrame:rect];
    //设置属性
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    //添加到窗口
    [WBKeyWindow addSubview:menu];
    
    return menu;
}

- (void)setContentView:(UIView *)contentView
{
    //先移除之前的视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    _contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

@end
