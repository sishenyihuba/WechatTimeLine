//
//  CommentView.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/8.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView
@property (nonatomic,copy)void(^commentDidClickBLock)(NSIndexPath* timeLineIndexPath,NSIndexPath *commentIndexpath);

-(void)configureCommentViewWith : (NSArray*)likeArray comments:(NSArray*)commentArray indexPath:(NSIndexPath*)indexpath;

@end
