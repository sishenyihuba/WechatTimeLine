//
//  HeaderView.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/10.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "HeaderView.h"
#import "UIDevice+TimeLine.h"
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        UIImageView * backgroundImageView = [UIImageView new];
        backgroundImageView.image = [UIImage imageNamed:@"WWDC"];
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:backgroundImageView];
        backgroundImageView.frame = CGRectMake(0, 64, ScreenWidth, frame.size.height-64-20);
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-20, ScreenWidth, 20)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        UIImageView * iconView = [UIImageView new];
        iconView.frame = CGRectMake(ScreenWidth-100, frame.size.height-80, 80, 80);
        iconView.image = [UIImage imageNamed:@"WWDCICON"];
        iconView.layer.borderColor = [UIColor whiteColor].CGColor;
        iconView.layer.borderWidth = 2;
        [self addSubview:iconView];
        
        UILabel * nameLabel = [UILabel new];
        nameLabel.frame = CGRectMake(ScreenWidth-220, iconView.frame.origin.y+20, 100, 30);
        nameLabel.text = @"一护";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:nameLabel];
    }
    return self;
}

@end
