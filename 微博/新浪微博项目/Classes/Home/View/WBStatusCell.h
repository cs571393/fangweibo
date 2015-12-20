//
//  WBStatusCell.h
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBStatusToolBar.h"

@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell

///微博数据
@property (nonatomic,strong) WBStatusFrame *statusFrame;

///创建一个可重用的cell
+ (WBStatusCell *)cellWithTableView:(UITableView *)tableView;

///工具栏view
@property (nonatomic,weak) WBStatusToolBar *toolBar;

@end
