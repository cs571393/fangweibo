//
//  WBNewFetureCell.h
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBNewFetureCell : UICollectionViewCell

///给外界传入image来显示
@property (nonatomic,strong) UIImage *image;

/// 用于判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
