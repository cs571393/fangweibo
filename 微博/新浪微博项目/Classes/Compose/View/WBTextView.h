//
//  WBTextView.h
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTextView : UITextView

///占位文字
@property (nonatomic,copy) NSString *placeholder;
///是否隐藏占位文字
@property (nonatomic,assign) BOOL hidePlaceholder;

@end
