//
//  WBComposeTool.h
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBComposeTool : NSObject

///发送微博
+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

///发送配图微博
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure;

@end
