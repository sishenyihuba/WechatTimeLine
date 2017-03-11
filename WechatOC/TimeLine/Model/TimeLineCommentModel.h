//
//  TimeLineCommentModel.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/8.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLineCommentModel : NSObject

@property (nonatomic,copy) NSString *commentId;
@property (nonatomic,copy) NSString *commentUserId;
@property (nonatomic,copy) NSString *commentUserName;
@property (nonatomic,copy) NSString *commentByUserId;
@property (nonatomic,copy) NSString *commentByUserName;
@property (nonatomic,copy) NSString *createDateStr;
@property (nonatomic,copy) NSString *commentText;

@end
