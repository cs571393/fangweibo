//
//  WBSatusParam.h
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusParam : NSObject

@property (nonatomic,copy) NSString *access_token;

@property (nonatomic,copy) NSString *since_id;

@property (nonatomic,copy) NSString *max_id;

@end
