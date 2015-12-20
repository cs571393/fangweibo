//
//  WBCover.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBCover.h"

@implementation WBCover

//点击蒙版时做的事情
//- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
//{
//    //移除蒙版
//    [self removeFromSuperview];
//    
//    //通知代理移除下拉菜单
//    if ([self.delegate respondsToSelector:@selector(coverDidClickedCover:)]) {
//        [self.delegate coverDidClickedCover:self];
//    }
//    
//}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //移除蒙版
    [self removeFromSuperview];
    
    //通知代理移除下拉菜单
    if ([self.delegate respondsToSelector:@selector(coverDidClickedCover:)]) {
        [self.delegate coverDidClickedCover:self];
    }
}

//暂时没用到
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

+ (instancetype)show
{
    WBCover *cover = [[WBCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [WBKeyWindow addSubview:cover];
    
    return cover;
}

@end
