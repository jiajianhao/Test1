//
//  UIColor+AddColor.h
//  FlatUI
//
//  Created by 大连科技学院 on 5/3/15.
//  Copyright (c) 2015 大连科技学院. All rights reserved.
//

#import <UIKit/UIKit.h>
//自定义颜色
@interface UIColor (AddColor)

// 通过16进制字符串创建颜色, 例如: #F173AC 是粉色
/*
 用法: 
 
view.backgroundColor = [UIColor colorFromHexCode:@"#F173AC"];
 
 */
+ (UIColor *) colorFromHexCode:(NSString *)hexString;
+ (UIColor *)colorFromHexCode:(NSString *)hexString alpha:(float)alpha;

+ (UIColor *) turquoiseColor;
+ (UIColor *) greenSeaColor;
+ (UIColor *) emerlandColor;
+ (UIColor *) nephritisColor;
+ (UIColor *) peterRiverColor;
+ (UIColor *) belizeHoleColor;
+ (UIColor *) amethystColor;
+ (UIColor *) wisteriaColor;
+ (UIColor *) wetAsphaltColor;
+ (UIColor *) midnightBlueColor;
+ (UIColor *) sunflowerColor;
+ (UIColor *) tangerineColor;
+ (UIColor *) carrotColor;
+ (UIColor *) pumpkinColor;
+ (UIColor *) alizarinColor;
+ (UIColor *) pomegranateColor;
+ (UIColor *) cloudsColor;
+ (UIColor *) silverColor;
+ (UIColor *) concreteColor;
+ (UIColor *) asbestosColor;
+ (UIColor *) ngaBackColor;
+ (UIColor *) ngaDarkColor;


// 随机颜色
+(UIColor *) randomColor;
+(UIColor *) randomColorWithAlpha:(CGFloat)alpha;


@end
