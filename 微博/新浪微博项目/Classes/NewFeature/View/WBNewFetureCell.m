//
//  WBNewFetureCell.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBNewFetureCell.h"
#import "WBTabController.h"

@interface WBNewFetureCell ()

///图片
@property (nonatomic,weak) UIImageView *imageView;
///分享按钮
@property (nonatomic,weak) UIButton *shareButton;
///开始按钮
@property (nonatomic,weak) UIButton *startButton;

@end

@implementation WBNewFetureCell

//判断是否最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    //如果是最后一页就显示
    if (indexPath.row == count - 1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        
        //创建分享按钮并设置其属性
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
        
    }
    return _shareButton;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        
        //创建开始按钮并设置其属性
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}

///开始进入微博
- (void)start
{
    //创建WBTabController
    WBTabController *tabBarVC = [[WBTabController alloc] init];
    
    //切换根控制器
    WBKeyWindow.rootViewController = tabBarVC;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        _imageView = imageView;
        
        //一定要加载conetentView
        [self.contentView addSubview:imageView];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

@end
