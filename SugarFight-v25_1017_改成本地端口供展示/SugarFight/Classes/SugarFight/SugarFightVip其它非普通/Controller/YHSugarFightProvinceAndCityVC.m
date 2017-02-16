//
//  YHSugarFightVip.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightProvinceAndCityVC.h"
#import "YHLoginOffVC.h"
#import "YHRankDetailVC.h"
#import "YHThreeDataTableView.h"
#import "YHThreeDataCell.h"
#import "YHPrideAndSwordVipTabBar.h"
#import "YHProvinceAndCityHomeResult.h"
#import "YHDistrictHeroCell.h"
#import "YHProvinceRankListParam.h"
#import "YHCommonDataTool.h"
#import "YHProvinceFocusParam.h"
#import "YHProvinceFocusResult.h"
#import "YHDistrictHomeParam.h"
#import "YHProvinceAndCityFocusCell.h"

static NSString *const YHStrUrlQueryHeroRank = @"jianpai/Msg/queryHeroRankByUid";
///下部3个tableView数据链接
static NSString *const YHStrUrlQuery3RankMsg = @"jianpai/Msg/queryThreeRankMsg";
static NSInteger const YHTtDownTableViewCellCount = 3;
static NSInteger const YHTtRightTableViewCellCount = 6;
static NSInteger const YHIsmTableViewCellCount = 3;
static NSInteger const YHWsTableViewCellCount = 3;
///loadRanklist请求时的参数
static NSInteger const YHPageSize = 10;
static NSInteger const YHFocusTableViewCellCount = 10;

@interface YHSugarFightProvinceAndCityVC ()<UITableViewDataSource, UITableViewDelegate>
/** 批次,默认选中按钮 */
@property (weak, nonatomic) IBOutlet UIButton *ttDistrictBtn;

@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttDownTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttRightTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ismTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *wsTableView;

@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttDetailTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ismDetailTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *wsDetailTableView;
/** YHProvinceAndCityHomeResult model */
@property (nonatomic, strong) YHProvinceAndCityHomeResult *proAndCityM;
/** 当前vc的上部的所有的tableView数组 */
@property (nonatomic, strong) NSArray<UITableView *> *tableViewsInTop;
/** 当前vc的下部'重点关注;的tableView数组 */
@property (nonatomic, strong) NSArray<UITableView *> *tableViewsFocus;
/** YHProvinceFocusResult model */
@property (nonatomic, strong) YHProvinceFocusResult *focusResult;

@end

@implementation YHSugarFightProvinceAndCityVC
- (NSArray *)tableViewsInTop{
    if (!_tableViewsInTop) {
        _tableViewsInTop = @[_ttDownTableView, _ttRightTableView, _ismTableView, _wsTableView];
    }
    return _tableViewsInTop;
}

- (NSArray *)tableViewsFocus{
    if (!_tableViewsFocus) {
        _tableViewsFocus = @[_ttDetailTableView, _ismDetailTableView, _wsDetailTableView];
    }
    return _tableViewsFocus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //加载标题
    [self getTitles];
    
    //1.加载上部当前省市信息
    [self loadNewDataAfterShiftingP];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self setupFrame];
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setup{
    
    [super setup];
    void (^setupTableView)(UITableView *tableView) = ^(UITableView *tableView){
        tableView.allowsSelection = NO;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.scrollEnabled = NO;
        tableView.userInteractionEnabled = NO;
    };
    
    setupTableView(self.ttDownTableView);
    setupTableView(self.ttRightTableView);
    setupTableView(self.ismTableView);
    setupTableView(self.wsTableView);
    setupTableView(self.ttDetailTableView);
    setupTableView(self.ismDetailTableView);
    setupTableView(self.wsDetailTableView);
    
}

- (void)setupFrame{
    self.ttDownTableView.rowHeight = self.ttDownTableView.yh_height / YHTtDownTableViewCellCount;
    self.ttRightTableView.rowHeight = self.ttRightTableView.yh_height / YHTtRightTableViewCellCount;
    self.ismTableView.rowHeight = self.ismTableView.yh_height / YHIsmTableViewCellCount;
    self.wsTableView.rowHeight = self.wsTableView.yh_height / YHWsTableViewCellCount;
}

//加载标题
- (void)getTitles{
    [self loadAllTitlesWithSuccess:nil failure:^(NSError *error) {
        YHLog(@"error = %@", error);
    }];
}

/**得到model出来的vc的标题
 *
 *  @param vipType      用户vip类别
 *  @param DistrictType 选中的区域的类别
 *  @param isDistric    是否请求的是区数据,点击上部TT,ISM,WS时请求的是区数据
 *  @return 返回字符串,为将model出的vc的标题,如:省 - TT,如果是区的用户,可能是:西区 - ISM
 */
- (NSString *)getTitleForPresentingVcWithVipType:(YHVipLevelType)vipType DistrictType:(YHDistrictDetailType)DistrictType isDistricData:(BOOL)isDistric{
    
    NSString *area = [GlobeSingle shareGlobeSingle].loginM.userArea;
    NSString *place = nil;
    
    if (isDistric) {//请求区数据
        NSRange range = [area rangeOfString:@"区"];
        place = [area substringWithRange:NSMakeRange(0, range.location + 1)];
    }else{
        switch (vipType) {
            case YHVipLevelTypeDistrict:{
                NSRange range = [area rangeOfString:@"区"];
                place = [area substringWithRange:NSMakeRange(0, range.location + 1)];
            }
                break;
            case YHVipLevelTypeProvince:{
                place = @"省";
            }
                break;
            case YHVipLevelTypeCity:{
                place = @"城市";
            }
                break;
                
            default:
                break;
        }
    }
    
    //拼接vc的title的渠道
    NSString *channel = nil;
    
    switch (DistrictType) {
        case YHDistrictDetailTypeTT:{
            channel = @"TT";
        }
            break;
        case YHDistrictDetailTypeISM:{
            channel = @"ISM";
        }
            break;
        case YHDistrictDetailTypeWS:{
            channel = @"WS";
        }
            break;
            
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@ - %@", place, channel];
}

- (void)setFocusResult:(YHProvinceFocusResult *)focusResult{
    _focusResult = focusResult;
    
    //设置'重点关注'的高度
    void (^setupTableViewCellHeight)(UITableView *tb, NSArray *modelArr) = ^(UITableView *tb, NSArray *modelArr){
        if (modelArr.count >= YHFocusTableViewCellCount) {
            tb.rowHeight = tb.yh_height / YHFocusTableViewCellCount;
        }else {
            CGFloat height = tb.yh_height / focusResult.ttRankMsg.count;
            height = height > 30.0f ? 30.0f : height;
            tb.rowHeight = height;
        }
    };
    
    setupTableViewCellHeight(self.ttDetailTableView, self.focusResult.ttRankMsg);
    setupTableViewCellHeight(self.ismDetailTableView, self.focusResult.ismRankMsg);
    setupTableViewCellHeight(self.wsDetailTableView, self.focusResult.wsRankMsg);
}


/**
 *  得到YHRankDetailVC 的 YHProvinceRankListParam请求参数
 *
 *  @param pType   为TOTAL,BENP.当传入'YHPTypeOther'时,直接赋值当前父类的求得的pChosen;
 *  @param channelType 为tt,ism,ws
 */
- (YHProvinceRankListParam *)getRankListParamWithPType:(YHPType)pType channelType:(YHChannelType)channelType{
    YHProvinceRankListParam *param = [[YHProvinceRankListParam alloc] init];
    param.areaId = [GlobeSingle shareGlobeSingle].loginM.data.user.userAreaId;
    if (pType == YHPTypeOther){
        //此时传入的参数无效,表示就是要得到当前切换的p的值,直接赋值即可
        param.totalOrBenP = self.pChosen;
    }else{//此时传入有效的参数,根据此参数判断得到选择的p
        param.totalOrBenP = [[YHCommonDataTool shareCommonDataTool] getSelectPWithpType:pType];
    }
    param.userWay = [[YHCommonDataTool shareCommonDataTool] getChannelWithChannelType:channelType];
    param.currentPage = @1;
    param.pageSize = @(YHPageSize);
    return param;
}

#pragma mark ------------------------------------------
#pragma mark network method
///父类遗留方法,当切换'累计','本p' 这两个选择的p时,重新加载相应的数据
- (void)loadNewDataAfterShiftingP{
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    YHDistrictHomeParam *param = [[YHDistrictHomeParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.totalOrBenP = self.pChosen;
    NSDictionary *paramDic = [param mj_keyValues];
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlQueryHeroRank params:paramDic success:^(NSDictionary * responseObj) {
        YHFunc
        self.proAndCityM = [YHProvinceAndCityHomeResult mj_objectWithKeyValues:responseObj];
        if (self.proAndCityM.status.integerValue == 1) {
            for (UITableView *tb in self.tableViewsInTop) {
                [tb reloadData];
            }
            
            //为了dismiss,在上面的请求成功后,再请求下面的数据.[SVProgressHUD dismiss]在下面这个方法中.
            [self loadFocusTop10];
            
        }else{
            [MBProgressHUD showError:self.proAndCityM.message];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
    
}

//加载下部排名列表
- (void)loadFocusTop10{
    
    YHProvinceFocusParam *param = [[YHProvinceFocusParam alloc] init];
    param.areaId = [GlobeSingle shareGlobeSingle].loginM.data.user.userAreaId;
    param.totalOrBenP = self.pChosen;
    NSDictionary *paramDic = [param mj_keyValues];
//    YHLog(@"paramDic = %@", paramDic);
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlQuery3RankMsg params:paramDic success:^(NSDictionary *  _Nonnull responseObj) {
        
//        YHLog(@"res = %@", responseObj);
        self.focusResult = [YHProvinceFocusResult mj_objectWithKeyValues:responseObj];
        if (self.focusResult.status.integerValue == 1) {
            for (UITableView *tb in self.tableViewsFocus) {
                [tb reloadData];
            }
            
        }else{
            [MBProgressHUD showError:self.proAndCityM.message];
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)settingAction:(id)sender {
    YHFunc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHLoginOffVC class]) bundle:nil];
    YHLoginOffVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///tt,ism,ws事件:tag分别为20,21,22
- (IBAction)pickChanenelAction:(UIButton *)sender {
    
    YHRankDetailVC *vc = (YHRankDetailVC *)[[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHRankDetailVC class])];
    
    //vc的标题
    YHVipLevelType vipType = [GlobeSingle shareGlobeSingle].loginM.vipLevel;
    YHDistrictDetailType btnTag = sender.tag - 20;
    vc.titleOfTop = [self getTitleForPresentingVcWithVipType:vipType DistrictType:btnTag isDistricData:NO];
    
    //vc请求时的参数
    YHChannelType channelType = sender.tag - 20;
    YHProvinceRankListParam *param = [self getRankListParamWithPType:YHPTypeOther channelType:channelType];
    vc.paramForRankList = param;
    
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///TT,ISM,WS点击时跳转到详情界面,tag分别为40,41,42
- (IBAction)detailTap:(UITapGestureRecognizer *)tapGes {
    
    NSInteger vipType = [GlobeSingle shareGlobeSingle].loginM.vipLevel;
    NSInteger tapViewTag = tapGes.view.tag - 40;
    YHRankDetailVC *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHRankDetailVC class])];
    
    //1.vc的标题
    vc.titleOfTop = [self getTitleForPresentingVcWithVipType:vipType DistrictType:tapViewTag isDistricData:YES];
    //2.vc的请求参数
    YHChannelType channelType = tapGes.view.tag - 40;
    YHProvinceRankListParam *param = [self getRankListParamWithPType:YHPTypeOther channelType:channelType];
    //请求区的信息,传的参数有变化
    param.areaId = [GlobeSingle shareGlobeSingle].loginM.userLargeAreaId;
    vc.paramForRankList = param;
    
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

#pragma mark ------------------------------------------
#pragma mark UITableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //1.上部的英雄榜
    NSArray *ttRankMs = self.proAndCityM.heroRankMsg.ttRank;
    NSArray *ismRankMs = self.proAndCityM.heroRankMsg.ismRank;
    NSArray *wsRankMs = self.proAndCityM.heroRankMsg.wsRank;
    
    if (tableView == self.ttDownTableView) {
        if (ttRankMs.count > YHTtDownTableViewCellCount) {
            return YHTtDownTableViewCellCount;
        }else{
            return ttRankMs.count;
        }
    }else if (tableView == self.ttRightTableView){
        if (ttRankMs.count > YHTtDownTableViewCellCount) {
            return ttRankMs.count - YHTtDownTableViewCellCount;
        }else{
            return 0;
        }
    }else if (tableView == self.ismTableView){
        return ismRankMs.count;
    }else if (tableView == self.wsTableView){
        return wsRankMs.count;
    }
    
    //2.下部的重点关注
    if (tableView == self.ttDetailTableView){
        return self.focusResult.ttRankMsg.count;
    }else if (tableView == self.ismDetailTableView){
        return self.focusResult.ismRankMsg.count;
    }else if (tableView == self.wsDetailTableView){
        return self.focusResult.wsRankMsg.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *returnCell = nil;
    //    cell.heightToDecrease = 0.1f;
    
    //1.上部的英雄榜
    if ([self.tableViewsInTop containsObject:tableView]) {
    
        CGFloat font = 8.0f;
        YHDistrictHeroCell *cell = [YHDistrictHeroCell cellWithTableView:tableView WithFontOfLeftData:font fontOfMidData:font fontOfRightData:font isBgOfRightData:YES];
        cell.leftDataColor = YHrgbColor(233, 232, 206);
        cell.leftBold = YES;
        cell.heightToDecrease = 1.0f;
        
        NSArray *ttRankMs = self.proAndCityM.heroRankMsg.ttRank;
        if (tableView == self.ttDownTableView) {//ttDownTableView
            cell.rankM = ttRankMs[indexPath.row];
            
        }else if (tableView == self.ttRightTableView){//ttRightTableView
            cell.rankM = ttRankMs[indexPath.row + YHTtDownTableViewCellCount];
        }else if (tableView == self.ismTableView){//ismTableView
            cell.rankM = self.proAndCityM.heroRankMsg.ismRank[indexPath.row];
        }else if (tableView == self.wsTableView){//wsTableView
            cell.rankM = self.proAndCityM.heroRankMsg.wsRank[indexPath.row];
        }
        returnCell = cell;
    }
    
    //2.下部的重点关注
    if ([self.tableViewsFocus containsObject:tableView]) {
        CGFloat font = 10.0f;
        YHProvinceAndCityFocusCell *cell = [YHProvinceAndCityFocusCell cellWithTableView:tableView WithFontOfLeftData:font fontOfMidData:font fontOfRightData:font isBgOfRightData:YES];
        cell.leftDataColor = YHrgbColor(233, 232, 206);
        cell.leftBold = YES;
        cell.heightToDecrease = 1.0f;
        
        if (tableView == self.ttDetailTableView) {  //ttDetailTableView
            cell.rankM = self.focusResult.ttRankMsg[indexPath.row];
        }else if (tableView == self.ismDetailTableView) {
            //ismDetailTableView
            cell.rankM = self.focusResult.ismRankMsg[indexPath.row];
        }else if (tableView == self.wsDetailTableView) {//wsDetailTableView
            cell.rankM = self.focusResult.wsRankMsg[indexPath.row];
        }
        returnCell = cell;
    }
    return returnCell;
}

@end
