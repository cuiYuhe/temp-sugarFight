//
//  YHMyApplellationVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHMyApplellationVC.h"
#import "YHUploadPicPerfectShopVC.h"
#import "YHUploadPicPrideVC.h"
#import "YHSugarFightWSVC.h"
#import "YHGetMyAppellationParam.h"
#import "YHGetMyAppellationResult.h"
#import "YHSeePrideUploadedVC.h"
#import "YHSeeHuaShanUploadedVC.h"
#import "YHCommonDataTool.h"
#import "YHLoginModel.h"
#import "YHUploadPicActivityVc.h"
#import "YHSeeUploadSwordGrideImgVc.h"

static NSString *const YHStrUrlGetUserLevel = @"jianpai/User/getUserLevel";

@interface YHMyApplellationVC ()
/** 称谓 */
@property (weak, nonatomic) IBOutlet UIImageView *appellationImageView;
/** 笑傲江湖 累计分数 */
@property (weak, nonatomic) IBOutlet UILabel *prideScoreLabel;
/** 笑傲江湖 获得的赞数量 */
@property (weak, nonatomic) IBOutlet UILabel *prideZanLabel;
/** 华山论剑 累计分数 */
@property (weak, nonatomic) IBOutlet UILabel *huaShanScoreLabel;
/** 华山论剑 获得的赞数量 */
@property (weak, nonatomic) IBOutlet UILabel *perfectZanLabel;
/** 中部的笑傲江湖view,如果是ws渠道用户须隐藏 */
@property (weak, nonatomic) IBOutlet UIView *prideView;
/** YHGetMyAppellationResult model */
@property (nonatomic, strong) YHGetMyAppellationResult *myAppResult;
/** 笑傲江湖 */
@property (weak, nonatomic) IBOutlet UIImageView *bcrImageView;
/** 华山论剑 */
@property (weak, nonatomic) IBOutlet UIImageView *battleImageView;


@end

@implementation YHMyApplellationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setup];
    //加载称谓数据
    [self loadApplellationData];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)setup{
    if ([self.presentingViewController isKindOfClass:[YHSugarFightWSVC class]]) {
        self.prideView.hidden = YES;
    }
    
    //设置标题
    YHTitlesResult *titles = [GlobeSingle shareGlobeSingle].titlesM;
    [titles setTitleImageWithTitleType:YHTitleTypeAppellation_bcr titleImageView:self.bcrImageView];
    [titles setTitleImageWithTitleType:YHTitleTypeAppellation_battle titleImageView:self.battleImageView];
}

///加载完毕我的称谓后的操作
- (void)setupAfterLoadMyApp{
    YHGetMyAppellationResult *appResult = self.myAppResult;
    self.prideZanLabel.text = [NSString stringWithFormat:@"%@次", appResult.bcrLikedNumber];
    self.perfectZanLabel.text = [NSString stringWithFormat:@"%@次", appResult.preLikedNumber];
    
    //等级,YHUserLevelType枚举自1开始
    YHUserLevelType levelType = [GlobeSingle shareGlobeSingle].loginM.data.user.userLevelId;
    NSString *levelName = [NSString stringWithFormat:@"level_0%zd", levelType];
    self.appellationImageView.image = [UIImage imageNamed:levelName];
    
}

//加载称谓数据
- (void)loadApplellationData{
    YHGetMyAppellationParam *param = [[YHGetMyAppellationParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetUserLevel params:paramDic success:^(id  _Nonnull responseObj) {
        
        self.myAppResult = [YHGetMyAppellationResult mj_objectWithKeyValues:responseObj];
        if (self.myAppResult.success.integerValue == 1) {
            [self setupAfterLoadMyApp];
        }else{
            [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark external methods
- (void)setPrideTotalScore:(double)prideTotalScore{
    _prideTotalScore = prideTotalScore;
    self.prideScoreLabel.text = [NSString stringWithFormat:@"%.1f", prideTotalScore];
}

- (void)setHuaShanTotalScore:(double)huaShanTotalScore{
    _huaShanTotalScore = huaShanTotalScore;
    self.huaShanScoreLabel.text = [NSString stringWithFormat:@"%.1f", huaShanTotalScore];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pridePostPicAction:(UIButton *)sender {
    YHFunc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHUploadPicPrideVC class]) bundle:nil];
    YHViewController *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

- (IBAction)perfectPostPicAction:(UIButton *)sender {
    YHFunc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHUploadPicActivityVc class]) bundle:nil];
    YHViewController *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

//查看已上传图片
- (IBAction)seePrideUploadedPicAction:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSeePrideUploadedVC class]) bundle:nil];
    YHSeePrideUploadedVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

//查看已上传图片
- (IBAction)seeHuaShanUploadedPicAction:(UIButton *)sender {
//     UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSeeHuaShanUploadedVC class]) bundle:nil];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSeeUploadSwordGrideImgVc class]) bundle:nil];
    YHViewController *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
}


@end
