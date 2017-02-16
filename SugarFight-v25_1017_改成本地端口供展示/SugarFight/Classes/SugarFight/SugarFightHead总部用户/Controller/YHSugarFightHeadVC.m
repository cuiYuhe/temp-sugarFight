//
//  YHSugarFightHeadVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightHeadVC.h"
#import "YHThreeDataTableView.h"
#import "YHLoginOffVC.h"
#import "YHDistrictDetailVC.h"
#import "YHHeadDistrictsResult.h"
#import "YHHeadTopRankListRankParam.h"
#import "YHHeadTopRankListRankResult.h"
#import "YHDistrictTopRankCell.h"

static NSString *const YHStrUrlGetAllDistrictMsg = @"jianpai/Msg/listAllAreaMsg";
static NSString *const YHStrUrlGetRankList = @"jianpai/Msg/listRankMsg";
static CGFloat const YHRowHeight = 25.0f;
static CGFloat const YHCellFont = 15.0f;

typedef NS_ENUM(NSInteger, YHSelectedDistrict){
    YHSelectedDistrictEast,
    YHSelectedDistrictSouth,
    YHSelectedDistrictWest,
    YHSelectedDistrictNorth,
};

@interface YHSugarFightHeadVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *tableView;
/** 选中的大区btn */
@property (nonatomic, weak) UIButton *selectedBtnOfDistrict;
/** 选中的人员类型btn */
@property (nonatomic, weak) UIButton *selectedBtnOfPersonType;
@property (weak, nonatomic) IBOutlet UIButton *eastDistrictSelectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *ttSelectedBtn;
/** YHGetDistrictsResult model */
@property (nonatomic, strong) YHHeadDistrictsResult *districtsResultM;
@property (weak, nonatomic) IBOutlet UIButton *activeOfEastBtn;
@property (weak, nonatomic) IBOutlet UIButton *activeOfSouthBtn;
@property (weak, nonatomic) IBOutlet UIButton *activeOfWestBtn;
@property (weak, nonatomic) IBOutlet UIButton *activeOfNorthBtn;

/** YHRankListRankResult model */
@property (nonatomic, strong) YHHeadTopRankListRankResult *rankListResultM;

@end

@implementation YHSugarFightHeadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //加载标题
    [self getTitles];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.rowHeight = YHRowHeight;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDistrictsMsg];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setup{
    
    [super setup];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = YHrgbColorWithAlpha(0, 0, 0, 0.4);
    
    //初始时第1个btn为选中状态
    self.selectedBtnOfDistrict = self.eastDistrictSelectedBtn;
    self.selectedBtnOfPersonType = self.ttSelectedBtn;
}

//加载标题
- (void)getTitles{
    [self loadAllTitlesWithSuccess:nil failure:^(NSError *error) {
        YHLog(@"error = %@", error);
    }];
}

- (void)loadDistrictsMsg{
    
    //在下个请求中(loadNewDataAfterShiftingP)隐藏
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetAllDistrictMsg params:nil success:^(id  _Nonnull responseObj) {
        self.districtsResultM = [YHHeadDistrictsResult mj_objectWithKeyValues:responseObj];
        if (self.districtsResultM.status.integerValue == 1) {
            [self setupAfterGetDistrictsResult];
        }else{

            [MBProgressHUD showError:self.districtsResultM.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (void)setupAfterGetDistrictsResult{
    //1.设置活跃度
    for (YHHeadDistrictMsgModel *model in self.districtsResultM.areaMsgs) {
        switch (model.areaId) {
            case YHDistrictTypeEast:
                [self.activeOfEastBtn setNormalTitle:model.activeness];
                break;
            case YHDistrictTypeSouth:
                [self.activeOfSouthBtn setNormalTitle:model.activeness];
                break;
            case YHDistrictTypeWest:
                [self.activeOfWestBtn setNormalTitle:model.activeness];
                break;
            case YHDistrictTypeNorth:
                [self.activeOfNorthBtn setNormalTitle:model.activeness];
                break;
            default:
                break;
        }
    }
    
    //2.加载初始的排名数据:东区,tt,本p
    [self loadNewDataAfterShiftingP];
}

///父类遗留方法,当切换'累计','本p' 这两个选择的p时,重新加载相应的数据
- (void)loadNewDataAfterShiftingP{
    
    //因为切换'本p','累计'时也调用这个方法,所以要svprogressHUD
    [SVProgressHUD showWithStatus:@"正在加载..."];
    YHHeadTopRankListRankParam *param = [[YHHeadTopRankListRankParam alloc] init];
    //因为areaId:1234代表东南西北区,所以tag-20 再 +1
    NSInteger districtFlag = self.selectedBtnOfDistrict.tag - 20 + 1;
    param.areaId = districtFlag;
    YHChannelType channelType = self.selectedBtnOfPersonType.tag - 30;
    param.userWay = [[YHCommonDataTool shareCommonDataTool] getChannelWithChannelType:channelType];
    param.totalOrBenP = self.pChosen;
    NSDictionary *paramDic = [param mj_keyValues];
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetRankList params:paramDic success:^(id  _Nonnull responseObj) {
        self.rankListResultM = [YHHeadTopRankListRankResult mj_objectWithKeyValues:responseObj];
        if (self.rankListResultM.status.integerValue == 1) {
            [self.tableView reloadData];
        }else{

            [MBProgressHUD showError:self.rankListResultM.message];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
    
}

#pragma mark ------------------------------------------
#pragma mark events
///查看具体排名,东南西北的tag分别为10,11,12,13
- (IBAction)rankDetailAction:(UIButton *)sender {
    
    YHDistrictDetailVC *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHDistrictDetailVC class])];
    
    NSInteger flag = sender.tag - 10;
    
    //1.请求参数
    YHDistrictDetailParam *param = [[YHDistrictDetailParam alloc] init];
    // 区域id,1234代表东南西北区
    param.areaId = @(flag + 1);
    param.totalOrBenP = self.pChosen;
    vc.paramOfDistrictDetail = param;
//    vc.areaId = flag + 1;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
    //2.标题
    switch (flag) {
        case YHSelectedDistrictEast:{
            vc.titleOfTop = @"title_east";
        }
            break;
        case YHSelectedDistrictSouth:{
            vc.titleOfTop = @"title_south";
        }
            break;
        case YHSelectedDistrictWest:{
            vc.titleOfTop = @"title_west";
        }
            break;
        case YHSelectedDistrictNorth:{
            vc.titleOfTop = @"title_north";
        }
            break;
        default:
            break;
    }
}

///1.中部view筛选范围,东南西北的tag分别为20,21,22,23.
- (IBAction)districtSelectAction:(UIButton *)sender {
    self.selectedBtnOfDistrict.selected = NO;
    sender.selected = YES;
    self.selectedBtnOfDistrict = sender;
    [self loadNewDataAfterShiftingP];
}

///2.中部view筛选范围,tt,ism,ws的tag分别为30,31,32.
- (IBAction)personTypeSelectAction:(UIButton *)sender {
    self.selectedBtnOfPersonType.selected = NO;
    sender.selected = YES;
    self.selectedBtnOfPersonType = sender;
    [self loadNewDataAfterShiftingP];
}

- (IBAction)settingAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHLoginOffVC class]) bundle:nil];
    YHLoginOffVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
}

#pragma mark ------------------------------------------
#pragma mark tableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rankListResultM.rank.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHDistrictTopRankCell *cell = (YHDistrictTopRankCell *)[YHDistrictTopRankCell cellWithTableView:tableView WithFontOfLeftData:YHCellFont fontOfMidData:YHCellFont fontOfRightData:YHCellFont isBgOfRightData:NO];
    cell.heightToDecrease = 2;
    
    cell.rankM = self.rankListResultM.rank[indexPath.row];
    return cell;
}


@end
