//
//  YFLStandardTime.h
//  YiFoLiNew
//
//  Created by 小雨科技 on 2017/3/28.
//  Copyright © 2017年 孙亚南. All rights reserved.
// 用于写时间转化的文件

#import <Foundation/Foundation.h>

@interface YFLStandardTime : NSObject
+(NSString*)todayShangHaiStandardTime;
//毫秒,返回年月日，时分秒
+(NSString*)changeToStandardTimeByMS:(NSString*)dateTemp;
//毫秒,返回年月日，时分
+(NSString*)changeToMinuteTimeByMS:(NSString*)dateTemp;
//毫秒,返回年月日
+(NSString*)changeToDayTimeByMS:(NSString*)dateTemp;

@end
