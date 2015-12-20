//
//  WBRetweetLabel.h
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatus;
@interface WBRetweetLabel : UIView

///转发的微博
@property (nonatomic,strong) WBStatus *status;

@end
