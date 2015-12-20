//
//  WBPhotosView.m
//  新浪微博项目
//
//  Created by neng on 15/10/5.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBPhotosView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "WBPhotoView.h"

@implementation WBPhotosView

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    //遍历全部的9个子控件
    for (int i = 0; i < self.subviews.count; i++) {
        //取出对应的子控件
        WBPhotoView *imageView = self.subviews[i];
        
        //如果i小于url的个数，就显示，剩下不够图片的就隐藏
        if (i < pic_urls.count) {
            
            imageView.hidden = NO;
            //显示图片
            //取出照片模型
            WBPhoto *photo = pic_urls[i];
            
            //设置图片
            imageView.photo = photo;
            
        }else{
            
            imageView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int row = 0;
    int cols = _pic_urls.count == 4 ? 2 : 3;
    
    //计算
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        row = i / cols;
        x = col * (w + margin);
        y = row * (h + margin);
        UIImageView *imageView = self.subviews[i];
        imageView.frame = CGRectMake(x, y, w, h);	
        
    }
    
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //创建子控件
        [self setUpAllChildView];
    }
    return self;
}

//敲击手势方法
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    //把WBPhoto转成MJPhote
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (WBPhoto *photo in _pic_urls) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        
        //转成高清图片
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = imageView;
        [arrM addObject:p];
        i++;
    }
    
    //创建图片浏览器
    MJPhotoBrowser *broswer = [[MJPhotoBrowser alloc] init];
    //设置图片源
    broswer.photos = arrM;
    broswer.currentPhotoIndex = imageView.tag;
    [broswer show];
    
}

//创建9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        
        WBPhotoView *imageView = [[WBPhotoView alloc] init];
        
        imageView.tag = i;
        //添加敲击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
    }
}


@end
