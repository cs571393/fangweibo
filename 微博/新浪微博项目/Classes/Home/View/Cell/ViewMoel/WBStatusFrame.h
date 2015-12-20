//
//  WBStatusFrame.h
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatus;
@interface WBStatusFrame : NSObject

///微博
@property (nonatomic,strong) WBStatus *status;

///原创微博view的frame
@property (nonatomic,assign) CGRect originalViewFrame;
//原创微博的子控件的frame
///头像
@property (nonatomic,assign) CGRect originalIconFrame;
///昵称
@property (nonatomic,assign) CGRect originalNameFrame;
///vip
@property (nonatomic,assign) CGRect originalVipFrame;
///时间
@property (nonatomic,assign) CGRect originalTimeFrame;
///来源
@property (nonatomic,assign) CGRect originalSourceFrame;
///正文
@property (nonatomic,assign) CGRect originalTextFrame;

///原创配图
@property (nonatomic,assign) CGRect originalPhotoFrame;

///转发微博的frame
@property (nonatomic,assign) CGRect retweetViewFrame;
//转发微博子控件的frame
///昵称
@property (nonatomic,assign) CGRect retweetNameFrame;
///正文
@property (nonatomic,assign) CGRect retweetTextFrame;
///转发配图
@property (nonatomic,assign) CGRect retweetPhotoFrame;

///工具栏的frame
@property (nonatomic,assign) CGRect toolBarFrame;


///cell的高度
@property (nonatomic,assign) CGFloat cellHeight;

@end
