//
//  UIButton+TimeLine.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "UIButton+TimeLine.h"

@implementation UIButton (TimeLine)
+(UIButton *)createButtonWith:(NSString *)title image:(NSString *)imageString selImage:(NSString *)selImageString target:(id)target selector:(SEL)sel {
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImageString] forState:UIControlStateSelected];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}
@end
