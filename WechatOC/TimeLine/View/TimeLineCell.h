//
//  TimeLineCell.h
//  WechatOC
//
//  Created by daixianglong on 2017/3/4.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineModel.h"
#import "OperationView.h"
@protocol TimeLineCellTapDelegate <NSObject>

-(void)didClickMoreBtn:(UIButton*)sender forIndexPath :(NSIndexPath*)indexPath;
-(void)didClickZanBtnWithIndexPath : (NSIndexPath*)indexPath;
-(void)didClickCommentBtnWithIndexPath : (NSIndexPath*)indexPath;
-(void)didClickCommentWithTimeLineIndexPath : (NSIndexPath*)timeLineIndexPath commentIndexPath:(NSIndexPath*)commentIndexPath;
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;
@end



@interface TimeLineCell : UITableViewCell

@property(nonatomic,weak)id <TimeLineCellTapDelegate>delegate;

-(void)configureCellWithModel:(TimeLineModel*)model forIndexPath : (NSIndexPath*)indexPath;

@property (nonatomic,strong)OperationView *operationView;

@end
