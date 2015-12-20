//
//  WBUserResult.m
//  新浪微博项目
//
//  Created by neng on 15/10/3.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBUserResult.h"

@implementation WBUserResult

///返回消息数
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

///总共的消息数
- (int)totalCount
{
    return self.messageCount + _status + _follower;
}

@end
