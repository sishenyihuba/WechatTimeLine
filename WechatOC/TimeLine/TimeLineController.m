//
//  TimeLineController.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/3.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "TimeLineController.h"
#import "DataManager.h"
#import "TimeLineCell.h"
#import "TimeLineLikeModel.h"
#import "TimeLineCommentModel.h"
#import "ChatKeyBoard.h"
#import "UIDevice+TimeLine.h"
#import "FaceSourceManager.h"
#import "FSActionSheet.h"
#import "ZJImageViewBrowser.h"
#import "HeaderView.h"
#import "ZJRefresh.h"
static NSString *cellIdetifier = @"TimeLineCell";

@interface TimeLineController () <TimeLineCellTapDelegate,ChatKeyBoardDataSource,ChatKeyBoardDelegate,FSActionSheetDelegate>
#pragma mark - 属性
@property (nonatomic,strong) NSArray *timeLineModels;
@property (nonatomic,strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic,strong)NSIndexPath *commentIndexpathInTimeLine;
@property (nonatomic,strong)NSIndexPath *replyIndexPath;
@property (nonatomic,assign)float totalKeybordHeight;
@end

@implementation TimeLineController


#pragma  mark - 周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240+64+20)];
    self.tableView.tableHeaderView = headerView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addRefreshHeaderViewWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.timeLineModels = [DataManager loadDataFromJson].mutableCopy;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView headerEndRefreshing];
        });
    }];
    
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
    [window addSubview:self.chatKeyBoard];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.timeLineModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    
    if (!cell) {
        cell = [[TimeLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
    }
    cell.delegate = self;
    TimeLineModel *model = self.timeLineModels[indexPath.row];
    
    [cell configureCellWithModel:model forIndexPath:indexPath];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TimeLineCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        TimeLineCell *cell = (TimeLineCell*)sourceCell;
        TimeLineModel *model = self.timeLineModels[indexPath.row];
        
        [cell configureCellWithModel:model forIndexPath:indexPath];
    }];
}

#pragma mark - TimeLineCellTapDelegate
-(void)didClickMoreBtn:(UIButton *)sender forIndexPath:(NSIndexPath *)indexPath {
    TimeLineModel *model = self.timeLineModels[indexPath.row];
    model.isExpand = !model.isExpand;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)didClickZanBtnWithIndexPath:(NSIndexPath *)indexPath {
    TimeLineLikeModel *like = [[TimeLineLikeModel alloc]init];
    like.userName = @"一护";
    like.userId = @"2017";
    TimeLineModel *model = self.timeLineModels[indexPath.row];
    NSMutableArray *likeArray = [NSMutableArray arrayWithArray:model.likes];
    model.isLiked == YES ? [likeArray removeLastObject] : [likeArray addObject:like];
    model.likes = [likeArray copy];
    model.isLiked = !model.isLiked;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath {
    self.commentIndexpathInTimeLine = indexPath;
    self.chatKeyBoard.placeHolder = @"评论";
    [self.chatKeyBoard keyboardUpforComment];
}


-(void)didClickCommentWithTimeLineIndexPath:(NSIndexPath *)timeLineIndexPath commentIndexPath:(NSIndexPath *)commentIndexPath {
    
    TimeLineModel *model = self.timeLineModels[timeLineIndexPath.row];
    TimeLineCommentModel *commentModel = model.commentMessages[commentIndexPath.row];
    if([commentModel.commentUserName isEqualToString:@"一护"]) {
        //点击的是自己的评论，需要弹框，提示删除
        NSMutableArray *actionSheetItems = [@[FSActionSheetTitleItemMake(FSActionSheetTypeHighlighted, @"删除")]
                                            mutableCopy];
        FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:nil cancelTitle:@"取消" items:actionSheetItems];
        // 展示并绑定选择回调
        __weak typeof (model) weakModel = model;
        __weak typeof(self) weakSelf = self;
        [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
            if(selectedIndex == 0) {
                NSMutableArray *mutableArray = weakModel.commentMessages.mutableCopy;
                [mutableArray removeObjectAtIndex:commentIndexPath.row];
                weakModel.commentMessages = mutableArray.copy;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[timeLineIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
    } else {
        self.commentIndexpathInTimeLine = timeLineIndexPath;
        self.replyIndexPath = commentIndexPath;
        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复: %@",commentModel.commentUserName];
        [self.chatKeyBoard keyboardUpforComment];
    }
}


-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath {
    ZJImageViewBrowser *browser = [[ZJImageViewBrowser alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageViewArray:array imageViewContainView:view];
    browser.selectedImageView = imageView;
    [browser show];
}


#pragma  mark - ChatKeyBoard Delegate
-(NSArray<MoreItem *> *)chatKeyBoardMorePanelItems {
    return nil;
}

-(NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems {
    return @[ [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"]];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}


-(void)chatKeyBoardSendText:(NSString *)text {
    TimeLineModel *model = self.timeLineModels[self.commentIndexpathInTimeLine.row];
    TimeLineCommentModel *newModel = [[TimeLineCommentModel alloc]init];
    newModel.commentUserName = @"一护";
    newModel.commentUserId = @"2017";
    newModel.commentText = text;
    
    if(self.replyIndexPath != nil) {
        TimeLineCommentModel *commentModel = model.commentMessages[self.replyIndexPath.row];
        newModel.commentByUserId = commentModel.commentUserId;
        newModel.commentByUserName = commentModel.commentUserName;
    }
    
    NSMutableArray *commentArray = model.commentMessages.mutableCopy;
    [commentArray addObject:newModel];
    model.commentMessages = commentArray.copy;
    [self.tableView reloadRowsAtIndexPaths:@[self.commentIndexpathInTimeLine] withRowAnimation:UITableViewRowAnimationNone];
    self.replyIndexPath = nil;
    [self.chatKeyBoard keyboardDownForComment];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.chatKeyBoard keyboardDownForComment];
    
    //让所有cell的operationView缩回去
    for(int i=0; i<=self.timeLineModels.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
         TimeLineCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.operationView.isShowing = NO;
    }
    
}


#pragma  mark - 通知  键盘升起后，设置tableview的contentOffset
-(void)keyboardWillChangeNotification:(NSNotification*)noti {
    NSDictionary *dict = noti.userInfo;
    CGRect rect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(rect.origin.y<ScreenHeight)
    {
        self.totalKeybordHeight  = rect.size.height + 49;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.commentIndexpathInTimeLine];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //坐标转换
        CGRect rect = [cell.superview convertRect:cell.frame toView:window];
        
        CGFloat dis = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
        CGPoint offset = self.tableView.contentOffset;
        offset.y += dis;
        if (offset.y < 0) {
            offset.y = 0;
        }
        
        [self.tableView setContentOffset:offset animated:YES];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma  mark - gettter / setter
- (NSArray *)timeLineModels {
    if (_timeLineModels == nil) {
        _timeLineModels = [[DataManager loadDataFromJson] mutableCopy];
    }
    return _timeLineModels;
}

-(ChatKeyBoard *)chatKeyBoard {
    if(_chatKeyBoard == nil) {
        _chatKeyBoard = [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.allowFace = YES;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.allowVoice = NO;
    }
    return _chatKeyBoard;
}

@end
