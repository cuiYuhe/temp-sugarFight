//
//  YHPrizeListVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPrizeListVc.h"
#import "YHPrizeListCell.h"
#import "YHPrizeOwnerInfoVc.h"
#import "YHPopAddressView.h"
#import "YHPopView.h"
#import "YHShakeDrawVc.h"
#import "YHPrizeListParam.h"
#import "YHPrizeListResult.h"
#import "YHWinnerCell.h"
#import "YHWinnerListResult.h" //中奖列表model

///礼品列表
static NSString *const YHStrUrlGiftList = @"jianpai/lottery/listGifts";
///获取中奖列表
static NSString *const YHStrUrlWinnerList = @"jianpai/lottery/lotterySuccessList";

///scrollTableView的行高
static CGFloat const YHScrollTableViewCellHeight = 30;

///scrollTableView的组数
static NSInteger const YHSectionCount = 10000;

@interface YHPrizeListVc ()<UITableViewDataSource, UITableViewDelegate, YHPrizeListCellDelegate, YHPrizeOwnerInfoVcDelegate, YHShakeDrawVcDelegate>

@property (weak, nonatomic) IBOutlet UITableView *prizeListTableView;
/** YHPrizeListResult */
@property (nonatomic, strong) YHPrizeListResult *prizeList;
/** 地址信息 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
/** 提示填写领奖人信息的框 */
@property (nonatomic, weak) YHPopView *popView ;
@property (weak, nonatomic) IBOutlet UITableView *scrollTableView;
@property (nonatomic, strong) NSTimer *timer;
/** scrollTableView 的偏移 */
@property (nonatomic, assign) CGFloat offset;
/** YHWinnerListResult */
@property (nonatomic, strong) YHWinnerListResult *winnerListM;

@end

@implementation YHPrizeListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self startTimer];
    
    //加载礼品列表
    [self loadGifts];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //加载中奖列表
    [self loadWinnerList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup{
    self.prizeListTableView.dataSource = self;
    self.prizeListTableView.delegate = self;
    
    [self.prizeListTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHPrizeListCell class]) bundle:nil] forCellReuseIdentifier:[YHPrizeListCell identifier]];
    
    self.scrollTableView.dataSource = self;
    self.scrollTableView.delegate = self;
    [self.scrollTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHWinnerCell class]) bundle:nil] forCellReuseIdentifier:[YHWinnerCell identifier]];
    self.scrollTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark ------------------------------------------
#pragma mark 滚动scrollTableView相关
- (void)startTimer{
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(scrollNameList) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
}

- (void)enterBackground{
    [self stopTimer];
}

- (void)becomeActive{
    [self startTimer];
}

///滚动中奖名单
- (void)scrollNameList{

    //方法一:
//    UITableViewCell *cell = self.scrollTableView.visibleCells.lastObject;
//    NSIndexPath *indexPath = [self.scrollTableView indexPathForCell:cell];
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
//    if (row + 1 > self.winnerListM.lotterySuccess.count) {
//        row = 0;
//        section ++;
//    }else{
//        row ++;
//    }
//    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
//    [UIView animateWithDuration:2 animations:^{
//        [self.scrollTableView scrollToRowAtIndexPath:toIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    }];
    
    //方法二:
    self.offset += YHScrollTableViewCellHeight;
    [UIView animateWithDuration:2 animations:^{
        
        [self.scrollTableView setContentOffset:CGPointMake(0, self.offset)];
    }];
}

#pragma mark ------------------------------------------
#pragma mark private method
///加载到礼品列表后的操作
- (void)setupAfterGetPrizeList{
    
    [self.prizeListTableView reloadData];
    if (self.prizeList.hasRecever) {
        self.addressLabel.text = self.prizeList.receiver.address;
        
    }else{ //没有地址信息
        //当中奖后没有个人信息时,弹出个人信息view
        YHPopAddressView *addView = [YHPopAddressView viewFromXib];
        addView.yh_size = CGSizeMake(YHScreenW - 100, 100);
        
        YHPopView *popView = [YHPopView popView];
        popView.clickNoResponse = YES;
        self.popView = popView;
        popView.contentView = addView;
        [popView show];
        
        //个人信息view点击确定时的操作.注:如果已有个人信息,else的方法不会调用.下面代码不会执行
        WeakSelf
        addView.clickCfmBlock = ^{
            StrongSelf
            YHPrizeOwnerInfoVc *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHPrizeOwnerInfoVc class])];
            vc.delegate = strongSelf;
            [strongSelf presentViewController:vc animated:YES completion:nil];
            
            //dismiss 提示填写领奖人信息的框
            if (strongSelf.popView) {
                [strongSelf.popView dismiss];
            }
        };
    }
}

///加载成功中奖列表后的操作
- (void)setupAfterLoadWinnerList{
    [self.scrollTableView reloadData];
}

#pragma mark ------------------------------------------
#pragma mark internet method
//加载礼品列表
- (void)loadGifts{
    
    [SVProgressHUD showWithStatus:nil];
    
    YHPrizeListParam *param = [[YHPrizeListParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGiftList params:paramDic success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        self.prizeList = [YHPrizeListResult mj_objectWithKeyValues:responseObj];
        if (self.prizeList.status.integerValue == 1) {
            
            [self setupAfterGetPrizeList];
        }else{
            [MBProgressHUD showError:self.prizeList.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

///加载中奖列表
- (void)loadWinnerList{
    
    [SVProgressHUD showWithStatus:@"正在加载中奖名单..."];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlWinnerList params:nil success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        self.winnerListM = [YHWinnerListResult mj_objectWithKeyValues:responseObj];
        if (self.winnerListM.status.integerValue == 1) {
            [self setupAfterLoadWinnerList];
        }else{
            [MBProgressHUD showError:self.winnerListM.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}


#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------------------------
#pragma mark UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.scrollTableView) {
        
        return YHSectionCount;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.prizeListTableView) {
        return self.prizeList.gifts.count;;
    }else if (tableView == self.scrollTableView) {
        return self.winnerListM.lotterySuccess.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.prizeListTableView) {
        YHPrizeListCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHPrizeListCell identifier] forIndexPath:indexPath];
        cell.giftM = self.prizeList.gifts[indexPath.row];
        cell.delegate = self;
        return cell;
        
    }else if (tableView == self.scrollTableView) {
        YHWinnerCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHWinnerCell identifier] forIndexPath:indexPath];
        cell.winnerSingleM = self.winnerListM.lotterySuccess[indexPath.row];
        return cell;
    }
    
    return nil;
}

#pragma mark ------------------------------------------
#pragma mark UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.prizeListTableView) {
        return 100;
    }else if (tableView == self.scrollTableView) {
        return YHScrollTableViewCellHeight;
    }
    return 44;
}

#pragma mark ------------------------------------------
#pragma mark YHPrizeListCellDelegate
- (void)prizeListCellDidClickDraw:(YHPrizeListCell *)cell{
    
    YHShakeDrawVc *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHShakeDrawVc class])];
    vc.delegate = self;
    NSIndexPath *indexPath = [self.prizeListTableView indexPathForCell:cell];
    YHPrizeSubGiftModel *giftM = self.prizeList.gifts[indexPath.row];
    vc.giftId = giftM.ID;
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark ------------------------------------------
#pragma mark YHPrizeOwnerInfoVcDelegate,
//*** 如果已有地址信息,当前vc成为YHPrizeOwnerInfoVc的代理不会执行
///成功提交领奖人信息后
- (void)prizeOwnerInfoVcDidSubmitPrizeInfo:(YHPrizeOwnerInfoVc *)prizeOwnerInfoVc prizeOwnerInfoM:(YHPrizeSubReceiverModel *)receiverM{
    
    self.addressLabel.text = receiverM.address;
}

///礼品收件人vc dismiss,而用户没有提交个人信息
- (void)prizeOwnerInfoVcWillDismissWhileNoSubmitInfo:(YHPrizeOwnerInfoVc *)prizeOwnerInfoVc{
    
    [self.popView show];
}

#pragma mark ------------------------------------------
#pragma mark YHShakeDrawVcDelegate
- (void)shakeDrawVcDidChangePrizeOwnerInfo:(YHShakeDrawVc *)drawVc changedInfo:(YHPrizeSubReceiverModel *)receiverM{
    
    self.addressLabel.text = receiverM.address;
}

@end
