//
//  CommentCell.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/8.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "CommentCell.h"
#import "UIColor+TimeLine.h"

@interface CommentCell ()
@property (nonatomic,strong)MLLinkLabel *commentLabel;
@end


@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SHOWCOLOR(245, 245, 245);
        [self.contentView addSubview:self.commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.top.mas_equalTo(self.contentView).offset(2);
        }];
        
        self.hyb_lastViewInCell = self.commentLabel;
        self.hyb_bottomOffsetToCell = 2.0;
    }
    return self;
}


- (void)configureCellWithCommentModel:(TimeLineCommentModel *)model {
    NSString *string =[NSString stringWithFormat:@"%@：%@",model.commentUserName,model.commentText];
    if(model.commentByUserName.length != 0)
    {
        string =[NSString stringWithFormat:@"%@回复%@：%@",model.commentUserName,model.commentByUserName ,model.commentText];
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    [text setAttributes:@{NSLinkAttributeName : model.commentUserName} range:[string rangeOfString:model.commentUserName]];
    if(model.commentByUserName.length != 0)
    {
        [text setAttributes:@{NSLinkAttributeName : model.commentByUserName} range:[string rangeOfString:model.commentByUserName]];
    }
    self.commentLabel.attributedText = text;
}


#pragma mark - getter/setter
-(MLLinkLabel *)commentLabel {
    if (_commentLabel == nil) {
        _commentLabel = [[MLLinkLabel alloc]init];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.numberOfLines = 0;
        _commentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : SHOWCOLOR(54, 71, 121)};
        _commentLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName : SHOWCOLOR(54, 71, 121), NSBackgroundColorAttributeName : [UIColor lightGrayColor]};
        _commentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 80 - 16;
    }
    return _commentLabel;
}
@end
