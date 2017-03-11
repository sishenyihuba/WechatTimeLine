//
//  TimeLineModel.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/3.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "TimeLineModel.h"
#import "TimeLineLikeModel.h"
#import "TimeLineCommentModel.h"
@implementation TimeLineModel


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"likes": [TimeLineLikeModel class],
             @"commentMessages" : [TimeLineCommentModel class]};
}


@end
