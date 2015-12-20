//
//  WBTabBar.h
//  新浪微博项目
//
//  Created by neng on 15/9/28.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;
@protocol WBTabBarDelegate <NSObject>

- (void)tabBar:(WBTabBar *)tabBar didClickBtnWith:(NSInteger)tag;

///加号按钮点击调用
- (void)tabBarDidClickPlusBtn:(WBTabBar *)tabBar;

@end

@interface WBTabBar : UIView

///tabBar上面的item
@property (nonatomic,strong) NSArray *items;

@property (nonatomic,weak) id<WBTabBarDelegate>delegate;

@end
