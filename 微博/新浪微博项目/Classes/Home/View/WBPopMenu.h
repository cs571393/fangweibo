//
//  WBPopMenu.h
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPopMenu : UIImageView

///在一个区域显示
+ (instancetype)showInRect:(CGRect)rect;

///下拉菜单显示的view
@property (nonatomic,weak) UIView *contentView;

///隐藏
+ (void)hide;

@end
