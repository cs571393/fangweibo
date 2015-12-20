//
//  WBTabBar.m
//  新浪微博项目
//
//  Created by neng on 15/9/28.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"

@interface WBTabBar ()

@property (nonatomic,weak) UIButton *plusBtn;

///存储自定义的tabBarButton，用来后面修改它的frame
@property (nonatomic,strong) NSMutableArray *btns;
///保存以选中的按钮
@property (nonatomic,weak) UIButton *selectedBtn;

@end

@implementation WBTabBar

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    //创建按钮
#pragma mark - 注意这里的改动
    for (UITabBarItem *item in items) {
        
        WBTabBarButton *btn = [WBTabBarButton buttonWithType:UIButtonTypeCustom];
        
        btn.item = item;
        
        //监听事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        //设置按钮的tag
        btn.tag = self.btns.count;
        
        //设置默认选中
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        //添加到自定义tabBar上面去
        [self addSubview:btn];
        
        //添加到数组
        [self.btns addObject:btn];
    }
}

- (void)btnClick:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    //通知代理选择了某个按钮
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickBtnWith:)]) {
        [self.delegate tabBar:self didClickBtnWith:btn.tag];
    }
}

- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置加号按钮的属性
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        
        //监听事件
        [btn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _plusBtn = btn;
        [self addSubview:btn];
    }
    return _plusBtn;
}

//加号按钮点击事件
- (void)plusBtnClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusBtn:)]) {
        [self.delegate tabBarDidClickPlusBtn:self];
    }
}

// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
//调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    for (UIView *tabBarButton in self.btns) {
            //给中间的加号按钮空出位置
            if (i == 2) {
                i = 3;
            }
            
            btnX = i *btnW;
            //调整位置
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            i++;
    }
    
    //设置按钮的位置
    self.plusBtn.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
}

@end
