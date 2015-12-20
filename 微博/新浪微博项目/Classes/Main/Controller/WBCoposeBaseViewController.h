//
//  WBCoposeBaseViewController.h
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTextView.h"

@interface WBCoposeBaseViewController : UIViewController

///导航栏标题
@property (nonatomic,copy) NSString *navTitle;

///占位文字
@property (nonatomic,copy) NSString *placeholoder;

///要评论的微博id
@property (nonatomic,copy) NSString *idStr;


///文本视图
@property (nonatomic,weak) WBTextView *textView;

///取消
- (void)cancel;

///发送
- (void)sendTitle;

@end
