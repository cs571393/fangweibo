//
//  WBComposeTabBar.h
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBComposeTabBar;
@protocol WBComposeTabBarDelegate <NSObject>

- (void)composeTabBar:(WBComposeTabBar *)composeTabBar didClickBtnWithTag:(NSInteger)tag;

@end

@interface WBComposeTabBar : UIView

@property (nonatomic,weak) id<WBComposeTabBarDelegate> delegate;

@end
