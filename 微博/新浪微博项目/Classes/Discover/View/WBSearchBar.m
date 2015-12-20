//
//  WBSearchBar.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        //设置放大镜
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        imageView.contentMode = UIViewContentModeCenter;
        imageView.width += 10;
        
        //要想leftView显示，就必须设置leftViewMode
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //设置文本框的左视图
        self.leftView = imageView;
    }
    return self;
}

@end
