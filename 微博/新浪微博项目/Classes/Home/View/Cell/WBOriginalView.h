//
//  WBOriginalView.h
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;
@interface WBOriginalView : UIImageView
///需要使用这个属性给子控件赋值、位置 
@property (nonatomic,strong) WBStatusFrame *statusFrame;

@end
