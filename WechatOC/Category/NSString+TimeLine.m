//
//  NSString+TimeLine.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "NSString+TimeLine.h"

@implementation NSString (TimeLine)
+(float)stringHeightWith:(NSString *)str font:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth {
    float height = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    return ceilf(height);
}
@end
