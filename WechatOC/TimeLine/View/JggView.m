//
//  JggView.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "JggView.h"

@interface JggView()
@property (nonatomic,strong)NSMutableArray *imageViewArray;
@end

@implementation JggView


-(void)setBigPics:(NSArray *)bigPics {
    _bigPics = bigPics;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (bigPics.count > 0) {
        CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 30 - 20 - 50)/3;
        [bigPics enumerateObjectsUsingBlock:^(NSString *  imageName, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            imageView.frame = CGRectMake((idx%3)*(itemWH + 5), (idx/3)*(itemWH + 5), itemWH, itemWH);
            if(bigPics.count == 4) {
                if(idx == 2) {
                    imageView.frame = CGRectMake(0, itemWH +5 , itemWH, itemWH);
                } else if(idx == 3) {
                    imageView.frame = CGRectMake(itemWH +5  , itemWH +5 , itemWH, itemWH);
                }
            }
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
            [self addSubview: imageView];
            [self.imageViewArray addObject:imageView];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tapGesture];
        }];
    }
}


-(void)tap:(UITapGestureRecognizer*)tap {
    UIImageView *tapImageView = (UIImageView*)tap.view;
    if(self.didClickImageWithCurrentImageViewBlock) {
        self.didClickImageWithCurrentImageViewBlock(tapImageView,self.imageViewArray,self);
    }
}


-(NSMutableArray *)imageViewArray {
    if(_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _imageViewArray;
}
@end
