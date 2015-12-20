//
//  WBHttpTool.m
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBHttpTool.h"
#import "AFNetworking.h"
#import "WBUploadParam.h"

@implementation WBHttpTool

//get请求
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    //底层使用AFN实现
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //请求
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //调用回调block
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败的回调
        if (failure) {
            failure(error);
        }
    }];
}

//POST请求
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    //底层使用AFN实现
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //请求
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //调用回调block
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败的回调
        if (failure) {
            failure(error);
        }
    }];
}

//上传
+ (void)Upload:(NSString *)URLString parameters:(id)parameters uploadParam:(WBUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimiType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
