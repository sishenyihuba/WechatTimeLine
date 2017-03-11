//
//  UIColor+TimeLine.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TimeLine)
/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/**
 随机得到一个颜色
 */
+ (UIColor*)randomColor;

/** 普通定义 */
#define SHOWCOLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
@end
