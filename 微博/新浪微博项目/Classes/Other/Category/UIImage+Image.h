//
//  UIImage+Image.h
//  新浪微博项目
//
//  Created by neng on 15/9/28.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (instancetype)imageWithOriginal:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
