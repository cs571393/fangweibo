//
//  WBHttpTool.h
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUploadParam;
@interface WBHttpTool : NSObject

/**
 *  GET请求
 *
 *  @param URLString  请求的url
 *  @param parameters 请求参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 *
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  POST请求
 *
 *  @param URLString  请求的url
 *  @param parameters 请求参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 *
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  上传
 *
 *  @param URLString   请求的url
 *  @param parameters  参数
 *  @param uploadParam 上传参数
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
+ (void)Upload:(NSString *)URLString parameters:(id)parameters uploadParam:(WBUploadParam *)uploadParam success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
