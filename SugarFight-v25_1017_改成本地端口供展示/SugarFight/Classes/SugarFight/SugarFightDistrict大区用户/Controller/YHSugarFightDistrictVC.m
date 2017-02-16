//
//  YHSugarFightDistrict.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightDistrictVC.h"
#import "YHThreeDataTableView.h"
#import "YHLoginOffVC.h"
#import "YHDistrictHomeResult.h"
#import "YHDistrictHeroCell.h"
#import "YHDistrictFocusCell.h"
///为了拿到YHDistrictDetailType枚举
#import "YHSugarFightProvinceAndCityVC.h"
#import "YHRankDetailVC.h"
#import "YHProvinceRankListParam.h"
#import "YHPrideAndSwordVipTabBar.h"
#import "YHDistrictHomeParam.h"

static NSInteger const YHTtDownTableViewCellCount = 3;
static NSInteger const YHTtRightTableViewCellCount = 6;
static NSInteger const YHIsmTableViewCellCount = 3;
static NSInteger const YHWsTableViewCellCount = 3;
static NSUInteger const YHPageSize = 10;

/**  根据用户id获取大区vip信息 */
static NSString *const YHStrUrlGetCurDistrictVip = @"jianpai/Msg/largeAreaVip";

@interface YHSugarFightDistrictVC ()<UITableViewDelegate, UITableViewDataSource, YHPrideAndSwordTabBarDelegate>
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttDownTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttRightTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ismTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *wsTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *focusTableView;
/** YHCurrentDistricResult model */
@property (nonatomic, strong) YHDistrictHomeResult *districtM;
/** 当前vc的所有的tableView数组 */
@property (nonatomic, strong) NSArray<UITableView *> *tableViews;

@end

@implementation YHSugarFightDistrictVC
- (NSArray *)tableViews{
    if (!_tableViews) {
        _tableViews = @[_ttDownTableView, _ttRightTableView, _ismTableView, _wsTableView, _focusTableView];
    }
    return _tableViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    //加载标题
    [self getTitles];
    
    //加载当前大区信息
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
        tableView.scrollEnabled = NO;
        tableView.allowsSelection = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        //还是能拦截点击,所以加了这句代码
        tableView.userInteractionEnabled = NO;
    };

    setupTableView(self.ttDownTableView);
    setupTableView(self.ttRightTableView);
    setupTableView(self.ismTableView);
    setupTableView(self.wsTableView);
    
    self.focusTableView.dataSource = self;
    self.focusTableView.delegate = self;
    self.focusTableView.showsVerticalScrollIndicator = NO;
    self.focusTableView.allowsSelection = NO;
    self.focusTableView.rowHeight = 30;
}

- (void)setupFrame{
    self.ttDownTableView.rowHeight = self.ttDownTableView.yh_height / YHTtDownTableViewCellCount;
    self.ttRightTableView.rowHeight = self.ttRightTableView.yh_height / YHTtRightTableViewCellCount;
    self.ismTableView.rowHeight = self.ismTableView.yh_height / YHIsmTableViewCellCount;
    self.wsTableView.rowHeight = self.wsTableView.yh_height / YHWsTableViewCellCount;
}

#pragma mark ------------------------------------------
#pragma mark network method

//加载标题
- (void)getTitles{
    [self loadAllTitlesWithSuccess:nil failure:^(NSError *error) {
        YHLog(@"error = %@", error);
    }];
}

///父类遗留方法,当切换'累计','本p' 这两个选择的p时,重新加载相应的数据
- (void)loadNewDataAfterShiftingP{
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    YHDistrictHomeParam *param = [[YHDistrictHomeParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.totalOrBenP = self.pChosen;
    NSDictionary *paramDic = [param mj_keyValues];
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetCurDistrictVip params:paramDic success:^(NSDictionary * responseObj) {
        self.districtM = [YHDistrictHomeResult mj_objectWithKeyValues:responseObj];
        if (self.districtM.status.integerValue == 1) {
            
            for (UITableView *tb in self.tableViews) {
                [tb reloadData];
            }
        }else{
            [MBProgressHUD showError:self.districtM.message];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)settingAction:(id)sender {
    YHFunc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHLoginOffVC class]) bundle:nil];
    YHLoginOffVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

//查看区排名详细事件,imageView的tag分别为10,11,12
- (IBAction)rankDetailTap:(UITapGestureRecognizer *)tapGes {
    YHRankDetailVC *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHRankDetailVC class])];
    
    //1.vc的标题
    //1.1 拼接vc的title的区
    NSString *area = [GlobeSingle shareGlobeSingle].loginM.userArea;
    NSRange range = [area rangeOfString:@"区"];
    NSString *place = [area substringWithRange:NSMakeRange(0, range.location + 1)];
    
    //1.2 拼接vc的title的渠道
    NSInteger tapViewTag = tapGes.view.tag - 10;
    NSString *channel = nil;
    
    switch (tapViewTag) {
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
    vc.titleOfTop = [NSString stringWithFormat:@"%@ - %@", place, channel];
    
    //2. vc请求时的参数
    YHProvinceRankListParam *param = [[YHProvinceRankListParam alloc] init];
    param.areaId = [GlobeSingle shareGlobeSingle].loginM.data.user.userAreaId;

//    param.totalOrBenP = [[YHCommonDataTool shareCommonDataTool] getSelectPWithpType:YHPTypeTotal];
    param.totalOrBenP = self.pChosen;
    
    YHChannelType channelType = tapGes.view.tag - 10;
    param.userWay = [[YHCommonDataTool shareCommonDataTool] getChannelWithChannelType:channelType];
    param.currentPage = @1;
    param.pageSize = @(YHPageSize);
    vc.paramForRankList = param;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

#pragma mark ------------------------------------------
#pragma mark tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *ttRankMs = self.districtM.heroRankMsg.ttRank;
    NSArray *ismRankMs = self.districtM.heroRankMsg.ismRank;
    NSArray *wsRankMs = self.districtM.heroRankMsg.wsRank;
    NSArray *focus = self.districtM.areaMsg;
    
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
    }else if (tableView == self.focusTableView){
        return focus.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *returnCell = nil;
    
    if (tableView == self.focusTableView){//重点关注cell
        CGFloat font = 14.0f;
        YHDistrictFocusCell *cell = [YHDistrictFocusCell cellWithTableView:tableView WithFontOfLeftData:font fontOfMidData:font fontOfRightData:font isBgOfRightData:NO];
        cell.focusM = self.districtM.areaMsg[indexPath.row];
        cell.heightToDecrease = 1.0f;
        returnCell = cell;
        
    }else{//不是重点关注cell
        CGFloat font = 8.0f;
        YHDistrictHeroCell *cell = [YHDistrictHeroCell cellWithTableView:tableView WithFontOfLeftData:font fontOfMidData:font fontOfRightData:font isBgOfRightData:YES];
        cell.leftDataColor = YHrgbColor(233, 232, 206);
        cell.leftBold = YES;
        cell.heightToDecrease = 1.0f;
        
        NSArray *ttRankMs = self.districtM.heroRankMsg.ttRank;
        if (tableView == self.ttDownTableView) {//ttDownTableView
            cell.rankM = ttRankMs[indexPath.row];
            
        }else if (tableView == self.ttRightTableView){//ttRightTableView
            
            cell.rankM = ttRankMs[indexPath.row + YHTtDownTableViewCellCount];
        }else if (tableView == self.ismTableView){//ismTableView
            cell.rankM = self.districtM.heroRankMsg.ismRank[indexPath.row];
        }else if (tableView == self.wsTableView){//wsTableView
            cell.rankM = self.districtM.heroRankMsg.wsRank[indexPath.row];
        }
        returnCell = cell;
    }
    return returnCell;
}

@end
