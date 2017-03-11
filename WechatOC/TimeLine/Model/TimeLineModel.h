//
//  TimeLineModel.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/3.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLineModel : NSObject
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSArray *messageBigPics;
@property (nonatomic,strong) NSString *timeTag;
@property (nonatomic,strong) NSArray *likes;
@property (nonatomic,strong) NSArray *commentMessages;

//文本是否展开
@property (nonatomic,assign) BOOL isExpand;

@property (nonatomic,assign) BOOL isLiked;

@end
