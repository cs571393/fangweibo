//
//  WBAccountParam.h
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccountParam : NSObject

@property (nonatomic,copy) NSString *client_id;
@property (nonatomic,copy) NSString *client_secret;
@property (nonatomic,copy) NSString *grant_type;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *redirect_uri;

@end
