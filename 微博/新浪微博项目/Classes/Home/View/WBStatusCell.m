//
//  WBStatusCell.m
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBOriginalView.h"
#import "WBRetweetView.h"

#import "WBStatus.h"
#import "WBStatusFrame.h"

@interface WBStatusCell ()

///原创微博View
@property (nonatomic,weak) WBOriginalView *originalView;
///转发微博view
@property (nonatomic,weak) WBRetweetView *retweetView;


@end

@implementation WBStatusCell


//重写setter方法来计算子控件的位置并赋值
- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //设置原创微博的frame
    _originalView.frame = statusFrame.originalViewFrame;
    //这里赋值了对应的view才能拿到子控件的位置和数据
    _originalView.statusFrame = statusFrame;
    
    //设置转发微博的frame
    _retweetView.frame = statusFrame.retweetViewFrame;
    _retweetView.statusFrame = statusFrame;
    
    //设置工具栏的frame
    _toolBar.frame = statusFrame.toolBarFrame;
    _toolBar.status = _statusFrame.status;
}



//创建可重用的cell
+ (WBStatusCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}


//自定义talbleViewCell重写构造方法就重写这个s
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //设置透明
        self.backgroundColor = [UIColor clearColor];
        
        //设置所有的子空间
        [self setUpAllChildView];
    }
    return self;
}

//设置所有的子控件
- (void)setUpAllChildView
{
    //原创微博
    WBOriginalView *originalView = [[WBOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    //转发微博
    WBRetweetView *retweetView = [[WBRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    //工具栏
    WBStatusToolBar *toolBar = [[WBStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
    
}

@end
