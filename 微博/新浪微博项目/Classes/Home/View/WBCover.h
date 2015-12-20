//
//  WBCover.h
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBCover;
@protocol WBCoverDelegate <NSObject>

- (void)coverDidClickedCover:(WBCover *)cover;

@end


@interface WBCover : UIView

///显示蒙版
+ (instancetype)show;

///灰色蒙版 暂时没用到
@property (nonatomic,assign) BOOL dimBackground;

@property (nonatomic,weak) id<WBCoverDelegate>delegate;

@end
