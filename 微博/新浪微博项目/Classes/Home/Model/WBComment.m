//
//  WBComment.m
//  新浪微博项目
//
//  Created by neng on 15/11/15.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBComment.h"
#import "NSDate+MJ.h"

@implementation WBComment

//返回日期
- (NSString *)created_at
{
    //Sun Oct 04 18:50:06 +0800 2015
    
    //转换格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //这是新浪返回数据的时间格式
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    //必须设置这个。不然解析不了
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    //把返回的字符串转成日期
    NSDate *create_at = [fmt dateFromString:_created_at];
    
    //比较
    if ([create_at isThisYear]) { //今年
        
        if ([create_at isToday]) { //今天
            
            //计算时间差
            NSDateComponents *cmp = [create_at deltaWithNow];
            
            if (cmp.hour > 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if ([create_at isYesterday]){ //昨天
            
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create_at];
            
        }else{ //前天
            
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create_at];
        }
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:create_at];
    }
    
    return _created_at;
}

@end
