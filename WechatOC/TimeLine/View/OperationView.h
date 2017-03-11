//
//  OperationView.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/7.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationView : UIView
@property(nonatomic,assign)BOOL isShowing;
@property(nonatomic,copy)NSString *praiseString;

//block
@property (nonatomic,copy) void(^zanBtnClickBlock)();
@property (nonatomic,copy) void(^commentBtnClickBlock)();
@end
