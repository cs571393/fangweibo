//
//  WBComposeTool.m
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBComposeTool.h"
#import "WBHttpTool.h"
#import "WBComposeParam.h"
#import "MJExtension.h"
#import "WBUploadParam.h"

@implementation WBComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    //创建参数模型
    WBComposeParam *param = [WBComposeParam param];
    param.status = status;
    
    [WBHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    WBComposeParam *param = [WBComposeParam param];
    param.status = status;
    
    //创建上传参数模型
    WBUploadParam *uploadParam = [[WBUploadParam alloc] init];
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.name = @"pic";
    uploadParam.fileName = @"image.png";
    uploadParam.mimiType = @"image/png";
    
    [WBHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadParam success:^(id responseObject) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

@end
