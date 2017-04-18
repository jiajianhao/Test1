//
//  NSString+Extensions.h
//  Test1
//
//  Created by 小雨科技 on 2017/4/13.
//  Copyright © 2017年 小雨科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)
+ (BOOL)isContainsTwoEmoji:(NSString *)string;
+ (NSString *)filterEmoji:(NSString *)string;
+(BOOL)stringContainsEmoji:(NSString *)string;
@end
