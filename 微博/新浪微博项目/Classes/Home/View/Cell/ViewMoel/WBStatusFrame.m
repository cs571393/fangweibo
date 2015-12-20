//
//  WBStatusFrame.m
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"

@implementation WBStatusFrame

//重写status的setter方法来计算控件的frame
- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    //计算原创view的frame
    [self setUpOriginalFrame];
    
    CGFloat tabBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (_status.retweeted_status) {
        
        //计算转发view的frame
        [self setUpRetweetFrame];
        
        tabBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    //计算工具栏的frame
    CGFloat tabBarX = 0;
    CGFloat tabBarW = WBScreenW;
    CGFloat tabBarH = 35;
    _toolBarFrame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
    
    //计算cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}

//据算转发微博的frame
- (void)setUpRetweetFrame
{
    //昵称
    CGFloat nameX = WBStatusCellMargin;
    CGFloat nameY = nameX;
    CGSize nameSize = [_status.retweetedName sizeWithFont:WBNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + WBStatusCellMargin;
    CGFloat textW = WBScreenW - 2 * WBStatusCellMargin;
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retWeetH = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
    //配图
    int count = (int)_status.retweeted_status.pic_urls.count;
    if (count) {
        
        CGFloat photoX = WBStatusCellMargin;
        CGFloat photoY = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
        CGSize photoSize = [self photoSizeWithCount:count];
        
        _retweetPhotoFrame = (CGRect){{photoX,photoY},photoSize};
        
        retWeetH = CGRectGetMaxY(_retweetPhotoFrame) + WBStatusCellMargin;
    }
    
    //转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retWeetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retWeetW = WBScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retWeetY, retWeetW, retWeetH);
}

//计算原创的frame
- (void)setUpOriginalFrame
{
    //头像
    CGFloat iconWH = 35;
    CGFloat iconX = WBStatusCellMargin;
    CGFloat iconY = iconX;
    _originalIconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + WBStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [_status.user.name sizeWithFont:WBNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (_status.user.vip) {
        
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + WBStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    //时间的来源的frame会变化，所以在originalView中实时更新
    
    //正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + WBStatusCellMargin;
    CGFloat textW = WBScreenW - 2 * WBStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
    
    //配图
    int count = (int)_status.pic_urls.count;
    if (count) {
        
        CGFloat photoX = WBStatusCellMargin;
        CGFloat photoY = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
        CGSize photoSize = [self photoSizeWithCount:count];
        
        _originalPhotoFrame = (CGRect){{photoX,photoY},photoSize};
        
        originalH = CGRectGetMaxY(_originalPhotoFrame) + WBStatusCellMargin;
    }
    
    
    //原创微博的frame
    CGFloat originalX = 0;
    CGFloat originalY = 10;
    CGFloat originalW = WBScreenW;

    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
}

#pragma mark - 计算配图的尺寸
- (CGSize)photoSizeWithCount:(int)count
{
    //获取总列数
    int cols = count == 4 ? 2 : 3;
    //获取总行数
    int rows = (count - 1) / cols + 1;
    CGFloat photeWH = 70;
    CGFloat w = cols * photeWH + (cols - 1) * WBStatusCellMargin;
    CGFloat h = rows * photeWH + (rows - 1) * WBStatusCellMargin;
    
    return CGSizeMake(w, h);
    
}

@end
