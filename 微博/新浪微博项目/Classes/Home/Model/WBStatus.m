//
//  WBStatus.m
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBStatus.h"
#import "WBPhoto.h"
#import "NSDate+MJ.h"

@implementation WBStatus

//重写转发微博的setter方法来设置被抓发微博的用户的用户名
- (void)setRetweeted_status:(WBStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    _retweetedName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
    
}

//实现这个方法就可以把对应的key转成对应的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WBPhoto class]};
}

//由于source不会频繁变动，所以不像日期，重写get方法
- (void)setSource:(NSString *)source
{
    //source =  <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    
    //截取字符串
    //有时候来源的长度会是0
    if (source.length > 0) {
        NSRange range = [source rangeOfString:@">"];
        source = [source substringFromIndex:range.length + range.location];
        range = [source rangeOfString:@"<"];
        source = [source substringToIndex:range.location];
    }
    
    _source = source;
}

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
