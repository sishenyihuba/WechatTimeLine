//
//  JggView.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JggView : UIView

@property (nonatomic,strong) NSArray *bigPics;

@property (nonatomic,copy) void(^didClickImageWithCurrentImageViewBlock)(UIImageView* currentImageView,NSMutableArray* imageViewArray, UIView* imageSuperView);
@end
