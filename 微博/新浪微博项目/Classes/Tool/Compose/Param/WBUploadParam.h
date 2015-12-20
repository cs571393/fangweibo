//
//  WBUploadParam.h
//  新浪微博项目
//
//  Created by neng on 15/10/6.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUploadParam : NSObject

///二进制数据
@property (nonatomic,strong) NSData *data;
///上传的参数名称
@property (nonatomic,copy) NSString *name;
///保存在服务器的文件名
@property (nonatomic,copy) NSString *fileName;
///上传文件的类型
@property (nonatomic,copy) NSString *mimiType;

@end
