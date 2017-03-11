//
//  CommentCell.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/8.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineCommentModel.h"
@interface CommentCell : UITableViewCell

-(void)configureCellWithCommentModel:(TimeLineCommentModel*)model;

@end
