//
//  WBStatusToolBar.h
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus,WBStatusToolBar;
@protocol WBStatusToolBarDelegate <NSObject>

///点击了工具栏的某个按钮调用
- (void)statusToolBar:(WBStatusToolBar *)statusToolBar didClickedBtnWithTag:(NSInteger)tag idStr:(NSString *)idStr;

@end

@interface WBStatusToolBar : UIImageView

//微博数据
@property (nonatomic,strong) WBStatus *status;

@property (nonatomic,weak) id<WBStatusToolBarDelegate> delegate;
@end
