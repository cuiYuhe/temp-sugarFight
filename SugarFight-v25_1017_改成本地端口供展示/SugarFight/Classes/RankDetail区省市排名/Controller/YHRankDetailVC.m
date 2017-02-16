//
//  YHRankDetailVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHRankDetailVC.h"
#import "YHRankDetailCell.h"
#import "YHProvinceRankListParam.h"
#import "YHProvinceRankListResult.h"
#import "YHRefreshFooter.h"
#import "YHRefreshHeader.h"

///27.根据条件查询排名/Msg/queryRankMsg
static NSString *const YHStrUrlQueryRankList = @"jianpai/Msg/queryRankMsg";

@interface YHRankDetailVC ()<UITableViewDataSource, UITableViewDelegate>
///顶部标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** YHProvinceRankListResult  */
@property (nonatomic, strong) YHProvinceRankListResult *rankListResult;
/** 请求时使用,请求第几页数据 */
@property (nonatomic, assign) NSInteger currentPage;
/** YHSingleRankModel array */
@property (nonatomic, strong) NSMutableArray<YHSingleRankModel *> *ranklist;
/** 最后一次的RankList的请求参数 */
@property (nonatomic, strong) NSDictionary *lastRankListParamDic;

@end

@implementation YHRankDetailVC
- (NSMutableArray<YHSingleRankModel *> *)ranklist{
    if (!_ranklist) {
        _ranklist = [[NSMutableArray alloc] init];
    }
    return _ranklist;
}

#pragma mark ------------------------------------------
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

- (void)dealloc{
    [YHHttpTool cancelAllTasks];
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setup{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHRankDetailCell class]) bundle:nil] forCellReuseIdentifier:[YHRankDetailCell identifier]];
    self.tableView.rowHeight = 60;
    
    //2.下拉与卡拉刷新控件
    self.currentPage = self.paramForRankList.currentPage.integerValue;
    self.tableView.mj_header = [YHRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRankListNewInfo)];
    
    YHRefreshFooter *footer = [YHRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRankListMoreInfo)];
    footer.stateLabel.textColor = YHGrayColor(255);
    self.tableView.mj_footer = footer;
    
    //3.标题
    self.titleLabel.text = self.titleOfTop;
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark ------------------------------------------
#pragma mark network method
- (void)loadRankListNewInfo{
    
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    //0.重置
    self.currentPage = 1;
    if (self.ranklist.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    //1.准备参数
    self.paramForRankList.currentPage = @(self.currentPage);
    NSDictionary *paramDic = [self.paramForRankList mj_keyValues];
    
    self.lastRankListParamDic = paramDic;
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlQueryRankList params:paramDic success:^(NSDictionary *  _Nonnull responseObj) {
        
        //一次请求还没结束,又来一次请求,则取消之前的请求.
        if (self.lastRankListParamDic != paramDic) return ;
        
        self.rankListResult = [YHProvinceRankListResult mj_objectWithKeyValues:responseObj];
        if (self.rankListResult.status.integerValue == 1) {
            [self.ranklist removeAllObjects];
            [self.ranklist addObjectsFromArray:self.rankListResult.rankMsg];
            [self.tableView reloadData];
            
        }else{
            [MBProgressHUD showError:self.rankListResult.message];
        }
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError * _Nonnull error) {
        if (self.lastRankListParamDic != paramDic) return ;
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (void)loadRankListMoreInfo{
    
    //结束上拉
    [self.tableView.mj_header endRefreshing];
    
    //1.准备参数
    self.currentPage++;
    self.paramForRankList.currentPage = @(self.currentPage);
    NSDictionary *paramDic = [self.paramForRankList mj_keyValues];
    self.lastRankListParamDic = paramDic;
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlQueryRankList params:paramDic success:^(id  _Nonnull responseObj) {
        
        [self.tableView.mj_footer endRefreshing];
        //一次请求还没结束,又来一次请求,则取消之前的请求.
        if (self.lastRankListParamDic != paramDic) return ;
        
        self.rankListResult = [YHProvinceRankListResult mj_objectWithKeyValues:responseObj];
        if (self.rankListResult.status.integerValue == 1) {
            if (self.rankListResult.rankMsg.count == 0){
                self.tableView.mj_footer.hidden = YES;
                [MBProgressHUD showError:@"没有新数据了"];//不弹出显示
                return ;
            }
            [self.ranklist addObjectsFromArray:self.rankListResult.rankMsg];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:self.rankListResult.message];
            //复位
            self.currentPage--;
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        
        self.currentPage--;
        if (self.lastRankListParamDic != paramDic) return ;
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}


- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------------------------
#pragma mark external method


#pragma mark ------------------------------------------
#pragma mark UITableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ranklist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHRankDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHRankDetailCell identifier]];
    cell.rankM = self.ranklist[indexPath.row];
    return cell;
}


@end
