//
//  UIButton+TimeLine.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TimeLine)

+(UIButton*)createButtonWith:(NSString*)title image:(NSString*)imageString selImage:(NSString*)selImageString target:(id)target selector:(SEL)sel;
@end
