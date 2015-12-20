//
//  WBUser.m
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    _vip = _mbtype > 2;
}

@end
