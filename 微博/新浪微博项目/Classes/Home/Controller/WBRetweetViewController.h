//
//  WBRetweetViewController.h
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBCoposeBaseViewController.h"

@class WBStatus;
@interface WBRetweetViewController : WBCoposeBaseViewController

///转发的微博
@property (nonatomic,strong) WBStatus *status;

@end
