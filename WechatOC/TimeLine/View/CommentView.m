//
//  CommentView.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/8.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "CommentView.h"
#import "UIColor+TimeLine.h"
#import "TimeLineLikeModel.h"
#import "CommentCell.h"
#import "TimeLineCommentModel.h"
static NSString *commentIdentifier = @"commentIdentifier";
@interface CommentView () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)MLLinkLabel *zanLabel;
@property (nonatomic,strong)UIView *divideLine;
@property (nonatomic,strong)UITableView *commentTableView;
//data
@property (nonatomic,strong)NSMutableArray *likeArray;
@property (nonatomic,strong)NSMutableArray *commentArray;

@property (nonatomic,strong)NSIndexPath *timeLineIndexPath;
@end

@implementation CommentView
-(instancetype)init {
    if(self = [super init]) {
        [self addSubview:self.zanLabel];
        [self addSubview:self.divideLine];
        [self addSubview:self.commentTableView];
        
        //layout
        [self.zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(3);
            make.left.mas_equalTo(self.mas_left).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
        }];
        
        [self.divideLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zanLabel.mas_bottom).offset(3);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        [self.commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.divideLine.mas_bottom).offset(3);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        
    }
    return self;
}



-(void)configureCommentViewWith:(NSArray *)likeArray comments:(NSArray *)commentArray indexPath:(NSIndexPath *)indexpath {
    self.likeArray = [NSMutableArray arrayWithArray:likeArray];
    self.commentArray =[NSMutableArray arrayWithArray:commentArray];
    self.timeLineIndexPath = indexpath;
    [self.commentTableView reloadData];
    
    
    //计算tableView的高度
    float height;
    for(TimeLineCommentModel *model in self.commentArray)
    {
        float cellHeight = [CommentCell hyb_heightForTableView:self.commentTableView config:^(UITableViewCell *sourceCell) {
            CommentCell *cell = (CommentCell *)sourceCell;
            [cell configureCellWithCommentModel:model];
        }];
        height += cellHeight;
    }
    [self.commentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
}



#pragma  mark - tableview Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
    if(cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentIdentifier];
    }
    cell.backgroundColor = SHOWCOLOR(245, 245, 245);
    TimeLineCommentModel *commentModel = self.commentArray[indexPath.row];
    [cell configureCellWithCommentModel:commentModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        CommentCell *cell = (CommentCell*)sourceCell;
        TimeLineCommentModel *commentModel = self.commentArray[indexPath.row];
        [cell configureCellWithCommentModel:commentModel];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.commentDidClickBLock) {
        self.commentDidClickBLock(self.timeLineIndexPath,indexPath);
    }
}


#pragma  mark - Utils Method
-(void)updateConstrains {
    if(self.likeArray.count > 0) {
        [self.zanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(3);
            make.left.mas_equalTo(self.mas_left).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
        }];
        [self.divideLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zanLabel.mas_bottom).offset(3);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        [self.commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.divideLine.mas_bottom).offset(3);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    } else {
        [self.zanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(self.mas_left).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.height.mas_equalTo(0);
        }];
        [self.divideLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zanLabel.mas_bottom).offset(3);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(0);
        }];
        [self.commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.divideLine.mas_bottom).offset(0);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    [self layoutIfNeeded];
}

#pragma  mark - getter/setter

-(void)setLikeArray:(NSMutableArray *)likeArray {
    _likeArray = likeArray;
    //如果没有likeArray，需要重新布局
    [self updateConstrains];
    
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"Like"];
    attachment.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon  = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:likeIcon];
    for (int i=0; i<likeArray.count; i++) {
        TimeLineLikeModel *model = likeArray[i];
        NSString *whoLike = model.userName;
        if (i > 0) {
            [attributedString appendAttributedString: [[NSAttributedString alloc]initWithString:@", "]];
        }
        NSAttributedString *name = [[NSAttributedString alloc]initWithString:whoLike attributes:@{NSLinkAttributeName:whoLike,NSFontAttributeName : [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName : [UIColor grayColor]}];
        [attributedString appendAttributedString:name];
    }
    
    self.zanLabel.attributedText = [attributedString copy];
}

-(void)setCommentArray:(NSMutableArray *)commentArray {
    _commentArray = commentArray;
    if(commentArray.count > 0) {
        if(self.likeArray.count > 0) {
            [self.commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.divideLine.mas_bottom).offset(3);
                make.left.mas_equalTo(self.mas_left).offset(0);
                make.right.mas_equalTo(self.mas_right).offset(0);
                make.bottom.mas_equalTo(self.mas_bottom);
            }];
        } else {
            [self.commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.divideLine.mas_bottom).offset(0);
                make.left.mas_equalTo(self.mas_left).offset(0);
                make.right.mas_equalTo(self.mas_right).offset(0);
                make.bottom.mas_equalTo(self.mas_bottom);
            }];
        }
        
    } else {
        [self.commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.divideLine.mas_bottom);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(0);
        }];
    }
}


-(MLLinkLabel *)zanLabel {
    if (_zanLabel == nil) {
        _zanLabel = [[MLLinkLabel alloc]init];
        _zanLabel.numberOfLines = 0;
        _zanLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 80 - 16;
        _zanLabel.linkTextAttributes = @{NSForegroundColorAttributeName:SHOWCOLOR(54, 71, 121)};
        _zanLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:SHOWCOLOR(54, 71, 121),
                                               NSBackgroundColorAttributeName:[UIColor lightGrayColor]};
    }
    return _zanLabel;
}


-(UIView *)divideLine {
    if(_divideLine == nil) {
        _divideLine = [[UIView alloc]init];
        _divideLine.backgroundColor = SHOWCOLOR(180, 180, 180);
    }
    return _divideLine;
}


-(UITableView *)commentTableView {
    if(_commentTableView == nil) {
        _commentTableView = [[UITableView alloc]init];
        _commentTableView.scrollEnabled = NO;
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        _commentTableView.backgroundColor = SHOWCOLOR(245, 245, 245);;
        _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _commentTableView;
}
@end
