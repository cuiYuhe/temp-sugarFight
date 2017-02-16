//
//  YHCommentsListVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommentsListVC.h"
#import "YHCommentModel.h"
#import "YHCommentCell.h"
#import "YHCommentsListResult.h"
#import "YHCommentModel.h"
#import "YHCommentsListParam.h"
#import "YHPostCmtParam.h"
#import "YHRefreshHeader.h"
#import "YHSeeHuaShanUploadedVC.h"
#import "YHSeePrideUploadedVC.h"
#import "YHSeeUploadSwordGrideImgVc.h"
#import "YHPushModel.h"
#import "NSString+Extension.h"

static NSString *const YHStrUrlGetCommentsList = @"jianpai/Score/getping";
static NSString *const YHStrUrlPing = @"jianpai/Score/ping";

@interface YHCommentsListVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, YHCommentCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** YHCommentModel array */
@property(nonatomic ,strong)NSMutableArray<YHCommentModel *> *comments;
@property (weak, nonatomic) IBOutlet UITextField *commentsField;
/** 包装textField的view,不需要时隐藏 */
@property (weak, nonatomic) IBOutlet UIView *cmtView;

@end

@implementation YHCommentsListVC


- (NSMutableArray<YHCommentModel *> *)comments{
    if (!_comments) {
        _comments = [[NSMutableArray alloc] init];
    }
    return _comments;
}

#pragma mark ------------------------------------------
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //加载评论
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealloc{
    [YHHttpTool cancelAllTasks];
}

#pragma mark ------------------------------------------
#pragma mark initialize
- (void)setup{
    [self.tableView registerClass:[YHCommentCell class] forCellReuseIdentifier:[YHCommentCell identifier]];
    self.tableView.mj_header = [YHRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCommentsList)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.commentsField.delegate = self;
    self.cmtView.hidden = self.isHideCmtField;
    UIView *leftV = [[UIView alloc] init];
    leftV.frame = CGRectMake(0, 0, 3, 0);
    self.commentsField.leftView = leftV;
    self.commentsField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark ------------------------------------------
#pragma mark network method
///加载评论列表
- (void)loadCommentsList{
    NSDictionary *paramDic = [self.getCommentparam mj_keyValues];
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlGetCommentsList params:paramDic success:^(id  _Nonnull responseObj) {
        YHCommentsListResult *cmtListM = [YHCommentsListResult mj_objectWithKeyValues:responseObj];
        if (cmtListM.stuatus.integerValue == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.comments removeAllObjects];
            [self.comments addObjectsFromArray:cmtListM.pings];
            for (YHCommentModel *cmt in self.comments) {
                cmt.cellWidth = self.tableView.frame.size.width - 2;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD showError:cmtListM.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        NSString *str = @"网络繁忙,请稍后重试.";
        [MBProgressHUD showError:str];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark public method
- (void)setReloadNetworkData:(BOOL)reloadNetworkData{
    
    [super setReloadNetworkData:reloadNetworkData];
    self.hideCmtField = YES;
    if (reloadNetworkData) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)setHideCmtField:(BOOL)hideCmtField{
    _hideCmtField = hideCmtField;
    if (hideCmtField) {
        [self.commentsField resignFirstResponder];
        self.cmtView.hidden = YES;
    }
}


- (void)setPushM:(YHPushModel *)pushM{
    [super setPushM:pushM];
    
    //标志
    self.disposableNoteTag = YES;
    self.hideCmtField = YES;
    
    //请求评论列表的参数
    YHCommentsListParam *param = [[YHCommentsListParam alloc] init];
    param.imgUrl = pushM.PING.imgUrl;
    param.imgId = pushM.PING.imgId;
    param.category = pushM.PING.category;
    self.getCommentparam = param;
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)postCmts:(UIButton *)sender {
    
    [self.commentsField resignFirstResponder];
    if ([self.commentsField.text yh_containsEmoji]) {
        [MBProgressHUD showError:@"评论不能含有表情!"];
        return;
    }
    
    self.postCmtParam.ping = self.commentsField.text;
    NSDictionary *paramDic = [self.postCmtParam mj_keyValues];
    
    self.commentsField.text = nil;
    [SVProgressHUD showWithStatus:nil];
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlPing params:paramDic success:^(id  _Nonnull responseObj) {
        YHBaseModel *model = [YHBaseModel mj_objectWithKeyValues:responseObj];
        if (model.status.integerValue == 1) {
            self.commentsField.text = nil;
            [self loadCommentsList];
        }else{
            [MBProgressHUD showError:model.message];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"网络繁忙."];
        YHLog(@"error = %@", error);
    }];
}

- (IBAction)backAction:(UIButton *)sender {
    
    if (self.isHideCmtField) {//回到看自己上传图片纪录vc
        
        YHSeeUploadCommenVc *vc = nil;
        NSInteger category = self.getCommentparam.category.integerValue;
        
        //如果是远程通知调出来,判断点击'返回'时,要跳转的是哪个vc
        switch (category) {
            case YHCategoryTypeHuaShanPerfect:{
                vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHSeeHuaShanUploadedVC class])];
            }
                break;
            case YHCategoryTypePrideBcr:{
                vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHSeePrideUploadedVC class])];
            }
                break;
            case YHCategoryTypeBattleGridImages:{
                vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHSeeUploadSwordGrideImgVc class])];
            }
                break;
                
            default:
                break;
        }
        
        if (self.isDisposableNoteTag) {
            vc.pushM = self.pushM;
            self.disposableNoteTag = NO;
        }
        [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    }else{//回到game vc,只需要dismiss就可以了
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark ------------------------------------------
#pragma mark UITableView data source & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHCommentCell identifier]];
    YHCommentModel *cmt = self.comments[indexPath.row];
    
    cell.comment = cmt;
    cell.delegate = self;
    cell.cmtVc = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHCommentModel *cmt = self.comments[indexPath.row];
    return cmt.cellHeight;
}

#pragma mark ------------------------------------------
#pragma mark UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    
    [self.commentsField resignFirstResponder];
}

#pragma mark ------------------------------------------
#pragma mark YHCommentCellDelegate
- (void)commentCellDidDingComment:(YHCommentCell *)cell totalDings:(NSNumber *)dings{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YHCommentModel *cmt = self.comments[indexPath.row];
    cmt.pingPushed = dings;
}

#pragma mark ------------------------------------------
#pragma mark TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self postCmts:nil];
    return YES;
}

@end
