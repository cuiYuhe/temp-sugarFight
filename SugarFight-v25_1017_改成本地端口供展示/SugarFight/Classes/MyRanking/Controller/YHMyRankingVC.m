//
//  YHMyRankingVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHMyRankingVC.h"
#import "YHCircleImageView.h"
#import "YHMyRankingCell.h"
#import "YHMyRankParam.h"
#import "YHLoginModel.h"
#import "YHCommonDataTool.h"
#import "YHMyRankResult.h"
#import "YHRefreshFooter.h"
#import "YHRefreshHeader.h"
#import "YHGetUserAvatarParam.h"
#import "YHGetUserAvatarResult.h"
#import "UIImageView+Extension.h"

//查看我的排名/Msg/myRankMsg
static NSString *const YHStrUrlGetRankMsg = @"jianpai/Msg/myRankMsg";
static NSString *const strUrlAvatar = @"jianpai/User/getMyava";
static NSUInteger const YHPageSize = 10;

@interface YHMyRankingVC ()<UITableViewDataSource, UITableViewDelegate>
///头像
@property (weak, nonatomic) IBOutlet YHCircleImageView *iconImgView;
///称谓
@property (weak, nonatomic) IBOutlet UILabel *appellationLabel;
///笑傲江湖分数
@property (weak, nonatomic) IBOutlet UIButton *prideScoreBtn;
///华山论剑分数
@property (weak, nonatomic) IBOutlet UIButton *huaShanScoreBtn;
///总分数
@property (weak, nonatomic) IBOutlet UIButton *totalScoreBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 本p,累计选中按钮 */
@property (nonatomic, weak) UIButton *selectedBtnOfP;
/** 地区选中按钮 */
@property (nonatomic, weak) UIButton *selectedBtnOfArea;
@property (weak, nonatomic) IBOutlet UIButton *thisPBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
/** YHSingleRankModel array */
@property (nonatomic, strong) NSMutableArray<YHSingleRankModel *> *ranklist;
/** 请求时使用,请求第几页数据 */
@property (nonatomic, assign) NSInteger currentPage;
/** 用户选择的是哪个类别,需要显示对应的aRank,cRank,pRank */
@property (nonatomic, assign) YHRankLevelType selectedLevelType;

@end

@implementation YHMyRankingVC
- (NSMutableArray<YHSingleRankModel *> *)ranklist{
    if (!_ranklist) {
        _ranklist = [[NSMutableArray alloc] init];
    }
    return _ranklist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    [self getAvatar];
    //加载我的排名信息
    [self loadMyRankNewInfo];
}

- (void)setup{
    self.selectedBtnOfArea = self.cityBtn;
    self.selectedBtnOfP = self.thisPBtn;
    self.selectedLevelType = self.selectedBtnOfArea.tag - 20;
    
    //1.设置tableView
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHMyRankingCell class]) bundle:nil] forCellReuseIdentifier:[YHMyRankingCell identifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //2.下拉与卡拉刷新控件
    self.tableView.mj_header = [YHRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMyRankNewInfo)];
    
    YHRefreshFooter *footer = [YHRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMyRankMoreInfo)];
    footer.stateLabel.textColor = YHGrayColor(255);
    self.tableView.mj_footer = footer;
    
    //3.分数与等级
    YHLoginModel *model = [GlobeSingle shareGlobeSingle].loginM;
    NSString *bcrScore = [NSString stringWithFormat:@"%.1f", model.scoreDetail.brcScore.floatValue];
    NSString *perfectScore = [NSString stringWithFormat:@"%.1f", model.scoreDetail.preScore.floatValue];
    NSString *totalScore = [NSString stringWithFormat:@"%.1f", model.scoreDetail.totalScore.floatValue];
    [self.prideScoreBtn setNormalTitle: bcrScore];
    [self.huaShanScoreBtn setNormalTitle:perfectScore];
    [self.totalScoreBtn setNormalTitle:totalScore];
    self.appellationLabel.text = model.data.user.userLevel;
    self.appellationLabel.font = YHFontFZXingKai(20)
    
}

///准备参数以请求排名列表
- (YHMyRankParam *)setupParamForLoadRankList{
    YHMyRankParam *param = [[YHMyRankParam alloc] init];
    GlobeSingle *single = [GlobeSingle shareGlobeSingle];
    param.uid = single.userID;
    param.userWay = single.loginM.userWay;
    
    YHPType pType = self.selectedBtnOfP.tag - 10;
    YHCommonDataTool *comTool = [YHCommonDataTool shareCommonDataTool];
    param.totalOrBenP = [comTool getSelectPWithpType:pType];
    
    YHRankLevelType rankLevel = self.selectedLevelType;
    param.rankLevel = [comTool getSelectRankLevelWithpType:rankLevel];
    param.currentPage = @(self.currentPage);
    param.pageSize = @(YHPageSize);
    
    return param;
}

#pragma mark ------------------------------------------
#pragma mark network method
- (void)getAvatar{
    YHGetUserAvatarParam *param = [[YHGetUserAvatarParam alloc] init];
    YHLoginModel *loginM = [GlobeSingle shareGlobeSingle].loginM;
    param.uid = loginM.data.user.userId;
    param.token = [GlobeSingle shareGlobeSingle].uuid;
    NSNumber *userAvatarId = loginM.data.user.userAvatarId;
    param.userAvatarId = userAvatarId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:strUrlAvatar params:paramDic success:^(id  _Nonnull responseObj) {
        YHGetUserAvatarResult *userAvatarResultM = [YHGetUserAvatarResult mj_objectWithKeyValues:responseObj];
        [self.iconImgView yh_setImageWithURLString:userAvatarResultM.ref.refValue imageName:@"placeholder_b"];
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

//加载我的排名信息
- (void)loadMyRankNewInfo{
    
    //0.重置
    self.currentPage = 1;
    if (self.ranklist.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    //1.准备参数
    YHMyRankParam *param = [self setupParamForLoadRankList];
    NSDictionary *paramDic = [param mj_keyValues];
    
    [SVProgressHUD showWithStatus:@"加载数据中.."];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetRankMsg params:paramDic success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        YHMyRankResult *rankResultM = [YHMyRankResult mj_objectWithKeyValues:responseObj];
        if (rankResultM.status.integerValue == 1) {
            [self.ranklist removeAllObjects];
            [self.ranklist addObjectsFromArray:rankResultM.rankMsg];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:rankResultM.message];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (void)loadMyRankMoreInfo{
    //1.准备参数
    self.currentPage++;
    YHMyRankParam *param = [self setupParamForLoadRankList];
    NSDictionary *paramDic = [param mj_keyValues];
    
    [SVProgressHUD showWithStatus:@"加载数据中.."];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetRankMsg params:paramDic success:^(id  _Nonnull responseObj) {
        
        YHMyRankResult *rankResultM = [YHMyRankResult mj_objectWithKeyValues:responseObj];
        if (rankResultM.status.integerValue == 1) {
            if (rankResultM.rankMsg.count == 0){
                [SVProgressHUD dismiss];
                [self.tableView.mj_footer endRefreshing];
                self.tableView.mj_footer.hidden = YES;
                //没有请求到,则恢复currentPage
                self.currentPage--;
                return ;
            }
            [self.ranklist addObjectsFromArray:rankResultM.rankMsg];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:rankResultM.message];
        }
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

///本p与累计 点击.本p与'累计'的tag分别是10,11
- (IBAction)thisPAndTotalAction:(UIButton *)sender {
    self.selectedBtnOfP.selected = NO;
    sender.selected = YES;
    self.selectedBtnOfP = sender;
    
    [self loadMyRankNewInfo];
}

///第二级筛选:区域. 城市,省份,大区的tag分别是:22,21,20
//YHRankLevelTypeArea, //YHRankLevelTypeProvince, //YHRankLevelTypeCity,
- (IBAction)regionAction:(UIButton *)sender {
    self.selectedBtnOfArea.selected = NO;
    sender.selected = YES;
    self.selectedBtnOfArea = sender;
    self.selectedLevelType = sender.tag - 20;
    
    [self loadMyRankNewInfo];
}

#pragma mark ------------------------------------------
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ranklist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHMyRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHMyRankingCell identifier]];
    cell.selectedLevelType = self.selectedLevelType;
    cell.rankM = self.ranklist[indexPath.row];
    return cell;
}


@end
