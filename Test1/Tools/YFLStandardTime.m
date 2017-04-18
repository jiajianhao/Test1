//
//  YFLStandardTime.m
//  YiFoLiNew
//
//  Created by 小雨科技 on 2017/3/28.
//  Copyright © 2017年 孙亚南. All rights reserved.
//

#import "YFLStandardTime.h"

@implementation YFLStandardTime

+(NSString *)todayShangHaiStandardTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    NSString *datenowStr = [formatter stringFromDate:datenow];
    

    return datenowStr;
}


+(NSString *)changeToStandardTimeByMS:(NSString *)dateTemp{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[dateTemp integerValue] / 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [dateFormatter stringFromDate:nd];
    
    return str;
}
+(NSString*)changeToMinuteTimeByMS:(NSString*)dateTemp{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[dateTemp integerValue] / 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str = [dateFormatter stringFromDate:nd];
    
    return str;
}

+(NSString*)changeToDayTimeByMS:(NSString*)dateTemp{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[dateTemp integerValue] / 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [dateFormatter stringFromDate:nd];
    
    return str;

}
@end
