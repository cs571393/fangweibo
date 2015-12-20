//
//  WBPhotoView.m
//  新浪微博项目
//
//  Created by neng on 15/10/5.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBPhotoView.h"
#import "WBPhoto.h"
#import "UIImageView+WebCache.h"

@interface WBPhotoView ()

@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation WBPhotoView

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        //设置图片的显示模式
        self.contentMode = UIViewContentModeScaleAspectFit;
        //裁剪多余
        self.clipsToBounds = YES;
        
        //创建右下gif的图片
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //判断是否显示gif图片
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        
        self.gifView.hidden = NO;
    }else{
        
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
