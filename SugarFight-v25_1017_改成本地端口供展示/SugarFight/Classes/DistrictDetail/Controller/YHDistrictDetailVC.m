//
//  YHDistrictDetailVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDistrictDetailVC.h"
#import "YHThreeDataCell.h"
#import "YHThreeDataTableView.h"
#import "YHDistrictHomeResult.h"
#import "YHDistrictFocusCell.h"
#import "YHDistrictHeroCell.h"

/** 根据区域id获取大区vip信息 */
static NSString *const YHStrUrlGetDistrictMsg = @"jianpai/Msg/largeAreaMsg";

static NSInteger const YHTtDownTableViewCellCount = 3;
static NSInteger const YHTtRightTableViewCellCount = 6;
static NSInteger const YHIsmTableViewCellCount = 3;
static NSInteger const YHWsTableViewCellCount = 3;

@interface YHDistrictDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttDownTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ttRightTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *ismTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *wsTableView;
@property (weak, nonatomic) IBOutlet YHThreeDataTableView *focusTableView;
/** YHDistrictHomeResult model,返回数据与这个模型相同 */
@property (nonatomic, strong) YHDistrictHomeResult *districtM;
/** 当前vc的所有的tableView数组 */
@property (nonatomic, strong) NSArray<UITableView *> *tableViews;
/** 英雄榜的cell的font */
@property (nonatomic, assign) CGFloat fontOfHeroCell;

@end

@implementation YHDistrictDetailVC
- (NSArray *)tableViews{
    if (!_tableViews) {
        _tableViews = @[_ttDownTableView, _ttRightTableView, _ismTableView, _wsTableView, _focusTableView];
    }
    return _tableViews;
}

- (CGFloat)fontOfHeroCell{
    if (!_fontOfHeroCell) {
        _fontOfHeroCell = 6.0f;
        if (YHScreenW >= YHScreenWidthOf6sPlus) {
            _fontOfHeroCell = 9.0f;
        }else if (YHScreenW >= YHScreenWidthOf6s){
            _fontOfHeroCell = 8.0f;
        }
    }
    return _fontOfHeroCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    //加载当前大区信息.放在viewDidLoad中[SVProgressHUD]不显示
    [self loadDistrictInfo];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self setupTableViewFrame];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setup{
    void (^setupTableView)(UITableView *tableView) = ^(UITableView *tableView){
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.allowsSelection = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.scrollEnabled = NO;
    };
    
    setupTableView(self.ttDownTableView);
    setupTableView(self.ttRightTableView);
    setupTableView(self.ismTableView);
    setupTableView(self.wsTableView);
    setupTableView(self.focusTableView);
    
    self.focusTableView.dataSource = self;
    self.focusTableView.delegate = self;
    self.focusTableView.showsVerticalScrollIndicator = NO;
    self.focusTableView.scrollEnabled = YES;
    
    setupTableView(self.ttDownTableView);
    setupTableView(self.ttRightTableView);
    setupTableView(self.ismTableView);
    setupTableView(self.wsTableView);
}

- (void)setupTableViewFrame{
    self.ttDownTableView.rowHeight = self.ttDownTableView.yh_height / YHTtDownTableViewCellCount;
    
    self.ttRightTableView.rowHeight = self.ttRightTableView.yh_height / YHTtRightTableViewCellCount;
    
    self.ismTableView.rowHeight = self.ismTableView.yh_height / YHIsmTableViewCellCount;
    
    self.wsTableView.rowHeight = self.wsTableView.yh_height / YHWsTableViewCellCount;
    self.focusTableView.rowHeight = 30;
}

#pragma mark ------------------------------------------
#pragma mark network method
//加载当前大区信息
- (void)loadDistrictInfo{
    
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *paramDic = [self.paramOfDistrictDetail mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetDistrictMsg params:paramDic success:^(id  _Nonnull responseObj) {
        
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
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setTitleOfTop:(NSString *)titleOfTop{
    _titleOfTop = [titleOfTop copy];
    self.titleImgView.image = [UIImage imageNamed:titleOfTop];
}


#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------------------------
#pragma mark UITableViewDataSource
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
    
    YHThreeDataCell *returnCell = nil;
    
    if (tableView == self.focusTableView){//重点关注cell
        CGFloat font = 14.0f;
        YHDistrictFocusCell *cell = [YHDistrictFocusCell cellWithTableView:tableView WithFontOfLeftData:font fontOfMidData:font fontOfRightData:font isBgOfRightData:NO];
        cell.focusM = self.districtM.areaMsg[indexPath.row];
        cell.heightToDecrease = 2.0f;
        cell.leftLabel.textAlignment = NSTextAlignmentCenter;
        returnCell = cell;
        
    }else{//不是重点关注cell
//        CGFloat font = 6.0f;
//        if (YHScreenW >= YHScreenWidthOf6sPlus) {
//            font = 9.0f;
//        }else if (YHScreenW >= YHScreenWidthOf6s){
//            font = 8.0f;
//        }
        YHDistrictHeroCell *cell = [YHDistrictHeroCell cellWithTableView:tableView WithFontOfLeftData:self.fontOfHeroCell fontOfMidData:self.fontOfHeroCell fontOfRightData:self.fontOfHeroCell isBgOfRightData:YES];
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
        
        cell.leftLabel.textAlignment = NSTextAlignmentLeft;
        returnCell = cell;
    }
    return returnCell;
}

@end
