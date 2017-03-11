//
//  TimeLineCell.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/4.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "TimeLineCell.h"
#import "NSString+TimeLine.h"
#import "JggView.h"
#import "UIColor+TimeLine.h"

#import "CommentView.h"
#import "UIColor+TimeLine.h"
static CGFloat margin = 10;
static CGFloat itemMargin = 5;
@interface TimeLineCell ()
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIButton *moreBtn;
@property (nonatomic,strong)JggView *jggView;
@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,strong)UILabel  *timeLabel;
@property (nonatomic,strong)UIButton *operationBtn;

@property (nonatomic,strong)CommentView *commentView;


@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)TimeLineModel *model;


@end


@implementation TimeLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupNoti];
    }
    return self;
}

-(void)configureCellWithModel:(TimeLineModel *)model forIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.model = model;
    //set cell data
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"me"]];
    self.nameLabel.text = model.userName;
    self.contentLabel.text = model.message;
    
    //设置moreBtn状态和约束
    float messageHeight = [NSString stringHeightWith:model.message font:15 maxWidth:[UIScreen mainScreen].bounds.size.width - 5 *margin - 50];
    if (messageHeight <= 80) {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom);
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    } else {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom);
            make.left.mas_equalTo(self.nameLabel.mas_left);
        }];
    }
    
    if (model.isExpand) {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-30);
            make.height.mas_lessThanOrEqualTo(messageHeight);
        }];
    } else {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-30);
            make.height.mas_lessThanOrEqualTo(80);
        }];
    }
    [self.moreBtn setSelected:model.isExpand];
    
    
    //set jggView
    CGSize jggSize;
    NSInteger count = model.messageBigPics.count;
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 3*margin - 20 - 50)/3;
//    if (count == 0) {
//        jggSize = CGSizeZero;
//        [self.timeLabel  mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.jggView.mas_bottom);
//            make.left.mas_equalTo(self.nameLabel.mas_left);
//        }];
//        [self.operationBtn  mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.jggView.mas_bottom);
//            make.left.mas_equalTo(self.contentLabel.mas_right).offset(-5);
//            make.size.mas_equalTo(CGSizeMake(25, 25));
//        }];
//    } else if(count == 4) {
    if(count == 4) {
         //4张配图
        CGFloat picViewWH = 2 * itemWH + itemMargin;
        jggSize = CGSizeMake(picViewWH, picViewWH);
        [self.timeLabel  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.jggView.mas_bottom).offset(margin);
            make.left.mas_equalTo(self.nameLabel.mas_left);
        }];
    } else {
        //其他配图
        NSInteger row = (count -1)/3 +1;
        jggSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 3*margin - 20 - 50, row * itemWH + (row -1)*itemMargin);
        [self.timeLabel  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.jggView.mas_bottom).offset(margin);
            make.left.mas_equalTo(self.nameLabel.mas_left);
        }];
    }
    [self.jggView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(margin);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.size.mas_equalTo(jggSize);
    }];
    
    [self.jggView setBigPics:model.messageBigPics];

    self.timeLabel.text = model.timeTag;
    
    
    //评论数据
    [self.commentView configureCommentViewWith:model.likes comments:model.commentMessages indexPath:indexPath];
//    if(model.likes.count ==0 && model.commentMessages.count ==0 ){
//        [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.commentView.mas_bottom);
//            make.left.right.mas_equalTo(0);
//            make.height.mas_equalTo(1);
//        }];
//    } else{
//        [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.commentView.mas_bottom).offset(margin);
//            make.left.right.mas_equalTo(0);
//            make.height.mas_equalTo(1);
//        }];
//    }
    
}

#pragma  mark - UI 方法
-(void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.jggView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.operationBtn];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.operationView];
    [self.contentView addSubview:self.commentView];
    
    //布局
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(margin);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_top);
        make.left.mas_equalTo(self.iconImageView.mas_right). offset(margin);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(margin);
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
    
    [self.jggView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(margin);
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(margin);
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
    
    [self.operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(margin);
        make.left.mas_equalTo(self.contentLabel.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.operationBtn.mas_centerY);
        make.right.mas_equalTo(self.operationBtn.mas_left).offset(-3);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.operationBtn.mas_bottom).offset(margin);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.operationBtn.mas_right);
    }];
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.commentView.mas_bottom).offset(margin);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.hyb_lastViewInCell = self.bottomLine;
    self.hyb_bottomOffsetToCell = 0;
    
    
    //给Block赋值
    [self setupBlocks];
}

-(void)setupNoti {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(letOtherCellsOperationBtnDisappear:) name:@"letOtherCellsOperationBtnDisappear" object:nil];
}


-(void)setupBlocks {
    __weak typeof(self.operationView) weakOpView = self.operationView;
    __weak typeof(self) weakSelf = self;
    self.operationView.zanBtnClickBlock = ^() {
        weakOpView.isShowing = NO;
        if([weakSelf.delegate respondsToSelector:@selector(didClickZanBtnWithIndexPath:)]) {
            [weakSelf.delegate didClickZanBtnWithIndexPath:weakSelf.indexPath];
        }
    };
    self.operationView.commentBtnClickBlock = ^() {
        weakOpView.isShowing = NO;
        if([weakSelf.delegate respondsToSelector:@selector(didClickCommentBtnWithIndexPath:)]) {
            [weakSelf.delegate didClickCommentBtnWithIndexPath:weakSelf.indexPath];
        }
    };
    
    self.commentView.commentDidClickBLock = ^(NSIndexPath* timeLineIndexPath,NSIndexPath *commentIndexpath) {
        if ([weakSelf.delegate respondsToSelector:@selector(didClickCommentWithTimeLineIndexPath:commentIndexPath:)]) {
            [weakSelf.delegate didClickCommentWithTimeLineIndexPath:timeLineIndexPath commentIndexPath:commentIndexpath];
        }
    };
    
    self.jggView.didClickImageWithCurrentImageViewBlock = ^(UIImageView* currentImageView,NSMutableArray* imageViewArray, UIView* imageSuperView) {
        if([weakSelf.delegate respondsToSelector:@selector(didClickImageViewWithCurrentView:imageViewArray:imageSuperView:indexPath:)]) {
            [weakSelf.delegate didClickImageViewWithCurrentView:currentImageView imageViewArray:imageViewArray imageSuperView:imageSuperView indexPath:weakSelf.indexPath];
        }
    };
}
#pragma  mark 点击事件
-(void)tapMoreBtn:(UIButton*)sender {
    if ([_delegate respondsToSelector:@selector(didClickMoreBtn:forIndexPath:)]) {
        [_delegate didClickMoreBtn:sender forIndexPath:self.indexPath];
    }
}

-(void)tapOperationBtn :(UIButton*)sender {
    if (self.model.isLiked) {
        self.operationView.praiseString = @"取消赞";
    } else {
        self.operationView.praiseString = @"赞";
    }
    self.operationView.isShowing = !self.operationView.isShowing;
    if ( self.operationView.isShowing) {
        //取消其他cell的opeationMenu show为false
        [[NSNotificationCenter defaultCenter]postNotificationName:@"letOtherCellsOperationBtnDisappear" object:self.operationView];
    }
}

#pragma  mark  - 通知
-(void) letOtherCellsOperationBtnDisappear: (NSNotification*)noti {
    OperationView *menu = (OperationView*)noti.object;
    if (menu != self.operationView && self.operationView.isShowing) {
        self.operationView.isShowing = NO;
    }
}


#pragma  mark getter/setter
-(UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}


-(UILabel *)nameLabel {
    if (_nameLabel== nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = SHOWCOLOR(54, 71, 121);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}


-(UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
    }
    return _bottomLine;
}

-(UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 45 - 50;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

-(UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]init];
        [_moreBtn setTitle:@"全文" forState:UIControlStateNormal];
        [_moreBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_moreBtn setTitleColor:SHOWCOLOR(54, 71, 121) forState:UIControlStateNormal];
        [_moreBtn sizeToFit];
        [_moreBtn setSelected:NO];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_moreBtn addTarget:self action:@selector(tapMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _moreBtn;
}

-(JggView *)jggView {
    if (_jggView == nil) {
        _jggView = [[JggView alloc]init];
    }
    return _jggView;
}

-(UILabel *)timeLabel {
    if(_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}

-(UIButton *)operationBtn {
    if (_operationBtn == nil) {
        _operationBtn = [[UIButton alloc]init];
        [_operationBtn setBackgroundImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_operationBtn addTarget:self action:@selector(tapOperationBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _operationBtn;
}


-(OperationView *)operationView {
    if (_operationView == nil) {
        _operationView = [[OperationView alloc]init];
    }
    return _operationView;
}

-(CommentView *)commentView {
    if (_commentView == nil) {
        _commentView =[[CommentView alloc]init];
        _commentView.backgroundColor = SHOWCOLOR(245, 245, 245);
    }
    return _commentView;
}

@end
