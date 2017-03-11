//
//  OperationView.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "OperationView.h"
#import "UIColor+TimeLine.h"
#import "UIButton+TimeLine.h"
@implementation OperationView
{
    UIButton *_likeButton;
    UIButton *_commentButton;
}

-(instancetype)init {
    if (self = [super init]) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = SHOWCOLOR(69, 74, 76);
        
        _likeButton = [UIButton createButtonWith:@"赞" image:@"AlbumLike" selImage:nil target:self selector:@selector(likeBtnDidTouch:)];
        _commentButton = [UIButton createButtonWith:@"评论" image:@"AlbumComment" selImage:nil target:self selector:@selector(commentBtnDidTouch:)];
        UIView *centerLine = [[UIView alloc]init];
        centerLine.backgroundColor = [UIColor grayColor];
        
        [self addSubview:_likeButton];
        [self addSubview:_commentButton];
        [self addSubview:centerLine];
        
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(5);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(90);
        }];
        [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(_likeButton.mas_right);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(1);
        }];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(centerLine.mas_right);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(90);
        }];
    }
    return self;
}

#pragma mark getter/setter

-(void)setIsShowing:(BOOL)isShowing {
    _isShowing = isShowing;
    if(isShowing) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(181);
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.superview layoutIfNeeded];
    }];
}

-(void)setPraiseString:(NSString *)praiseString {
    _praiseString = praiseString;
    [_likeButton setTitle:praiseString forState:UIControlStateNormal];
}



#pragma  mark - 点击事件
-(void)likeBtnDidTouch:(UIButton*)sender{
    if (self.zanBtnClickBlock) {
        self.zanBtnClickBlock();
    }
}
-(void)commentBtnDidTouch:(UIButton*)sender {
    if(self.commentBtnClickBlock) {
        self.commentBtnClickBlock();
    }
}
                                                                                                                            
@end
