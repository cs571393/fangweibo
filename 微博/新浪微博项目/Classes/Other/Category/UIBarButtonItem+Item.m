//
//  UIBarButtonItem+Item.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置属性和大小
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    //监听事件
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
