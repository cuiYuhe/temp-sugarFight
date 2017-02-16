//
//  YHSugarFightNotWSVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightNotWSVC.h"
#import "YHUploadPicPrideVC.h"
#import "YHUploadPicPerfectShopVC.h"
#import "YHSeePrideUploadedVC.h"
#import "YHSeeHuaShanUploadedVC.h"
#import "YHFindErrorVC.h"

#import "YHAlertController.h"
#import "YHUploadPicActivityVc.h"

static NSString *const YHStrUrlGetRealScoreDetail = @"jianpai/User/getRealScoreDetail";

@interface YHSugarFightNotWSVC ()
/** 排名 得分 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *districtRankBtn;
@property (weak, nonatomic) IBOutlet UIButton *provinceRankBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityRankBtn;
/** 笑傲江湖 得分 */
@property (weak, nonatomic) IBOutlet UILabel *prideShopScoreLabel;
/** 华山论剑得分 */
@property (weak, nonatomic) IBOutlet UILabel *perfectShopScoreLabel;
/** 闭关修炼得分 */
@property (weak, nonatomic) IBOutlet UILabel *adventureScore;
/** 此view的宽度,可作为笑傲江湖,华山论剑,总分进度条的依照 */
@property (weak, nonatomic) IBOutlet UIView *prideBigView;
/** 笑傲江湖 进度条 */
@property (weak, nonatomic) IBOutlet UIView *prideSmallView;
/** 华山论剑 进度条 */
@property (weak, nonatomic) IBOutlet UIView *perfectSmallView;
/** 总分 进度条 */
@property (weak, nonatomic) IBOutlet UIView *totalScoreSmallView;
/** 左下角的等级图片,需要切换:efficacy_01 */
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
/** 累计结果按钮 */
@property (weak, nonatomic) IBOutlet UIButton *totalResultBtn;
/** 本P结果按钮 */
@property (weak, nonatomic) IBOutlet UIButton *thisPBtn;

/** 标识笑傲江湖分数变化 */
@property (weak, nonatomic) IBOutlet UIButton *prideScoreChangeBtn;
/** 标识 华山论剑 分数变化 */
@property (weak, nonatomic) IBOutlet UIButton *huaMountainChangeBtn;
/** 标识 闯关修炼 分数变化 */
@property (weak, nonatomic) IBOutlet UIButton *studyChangeBtn;

/** 标题-华山论剑 */
@property (weak, nonatomic) IBOutlet UIImageView *titleGame1ImgView;
/** 标题-华山论剑 */
@property (weak, nonatomic) IBOutlet UIImageView *titleGame2ImgView;
/** 标题-闯关修炼 */
@property (weak, nonatomic) IBOutlet UIImageView *titleStudyImgView;
/** 标题-功力指数 */
@property (weak, nonatomic) IBOutlet UIImageView *titleScoreImgView;
/** 抽奖按钮 */
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;

@end

@implementation YHSugarFightNotWSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //加载标题
    [self getTitles];
    
    //加载网络数据,获取用户实时分数明细
    [self loadRealScoreDetailData];
}

#pragma mark ------------------------------------------
#pragma mark initialize
- (void)setup{
    
    YHLoginModel *loginM = [GlobeSingle shareGlobeSingle].loginM;
    NSString *imgName = [NSString stringWithFormat:@"efficacy_0%zd", loginM.data.user.userLevelId];
    [self.levelBtn setNormalBackgroundImage:imgName];
    
    if (YHAccountOfApple) {//如果是苹果审核账户,隐藏抽奖btn
        self.drawBtn.hidden = YES;
    }
}

//加载标题
- (void)getTitles{
    [self loadAllTitlesWithSuccess:^(YHTitlesResult *titlesM) {
        
        //设置标题图片
        [titlesM setTitleImageWithTitleType:YHTitleTypeHomepage_bcr titleImageView:self.titleGame1ImgView];
        [titlesM setTitleImageWithTitleType:YHTitleTypeHomepage_battle titleImageView:self.titleGame2ImgView];
        [titlesM setTitleImageWithTitleType:YHTitleTypeHomepage_biguan titleImageView:self.titleStudyImgView];
        [titlesM setTitleImageWithTitleType:YHTitleTypeHomepage_gongli titleImageView:self.titleScoreImgView];
        
    } failure:^(NSError * error) {
        [MBProgressHUD showError:@"获取标题失败."];
        YHLog(@"error = %@", error);
    }];
}

//加载网络数据,获取用户实时分数明细
- (void)loadRealScoreDetailData{
    NSDictionary *paramDic = @{@"userId" : [GlobeSingle shareGlobeSingle].userID};
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetRealScoreDetail params:paramDic success:^(id  _Nonnull responseObj) {
        
        self.realScoreDetail = [YHRealScoreDetailModel mj_objectWithKeyValues:responseObj];
        if (self.realScoreDetail.status.integerValue != 1) {
            [MBProgressHUD showError:@"加载失败,请稍后重试."];
            return ;
        }
        
        [self totalResultAction:nil];
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
        [SVProgressHUD dismiss];
    }];
}


#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)settingAction:(id)sender {
    YHFunc
    [self settingActionWithRealScoreDetail:self.realScoreDetail];
}
- (IBAction)addScoreAction:(id)sender {
    [self dailySignInAction];
}
- (IBAction)totalResultAction:(UIButton *)sender {
    YHFunc
    sender.selected = YES;
    self.thisPBtn.selected = NO;
    
    //更新相应控件的值
    YHScoreDetailModel *scoreDetailM = self.realScoreDetail.scoreDetail;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.totalScore.floatValue];
    self.scoreLabel.font = YHFontFZHuangCao(30);
    
    void (^setupBtn)(UIButton *btn, NSNumber *num, CGFloat fontSize) = ^(UIButton *btn, NSNumber *num, CGFloat fontSize){
        [btn setNormalTitle:[NSString stringWithFormat:@"第%@名", num]];
        btn.titleLabel.font = YHFontFZHuangCao(fontSize);
        
    };
    
    CGFloat fontSize = 14.0f;
    if (YHScreenW >= 375.0f) {//iphone6及以上的宽度
        fontSize = 18.0f;
    }
    setupBtn(self.districtRankBtn, scoreDetailM.areaRanking, fontSize);
    setupBtn(self.provinceRankBtn, scoreDetailM.provinceRanking, fontSize);
    setupBtn(self.cityRankBtn, scoreDetailM.cityRanking, fontSize);
    
    self.prideShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.brcScore.doubleValue];
    self.perfectShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.preScore.floatValue];
        self.adventureScore.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.stadyScore.floatValue];

    self.prideSmallView.yh_width = self.prideBigView.yh_width * scoreDetailM.bcrRate.doubleValue;
    self.perfectSmallView.yh_width = self.prideBigView.yh_width * scoreDetailM.preRate.doubleValue;
    self.totalScoreSmallView.yh_width = self.prideBigView.yh_width * scoreDetailM.totalRate.doubleValue;
    
    ///分数变化
    self.prideScoreChangeBtn.selected = scoreDetailM.brcScoreChange.integerValue == -1;
    self.huaMountainChangeBtn.selected = scoreDetailM.preScoreChange.integerValue == -1;
    self.studyChangeBtn.selected = scoreDetailM.stadyScoreChange.integerValue == -1;
}

- (IBAction)thisPAction:(UIButton *)sender {
    YHFunc
    sender.selected = YES;
    self.totalResultBtn.selected = NO;
    
    YHScoreDetailModel *scoreDetailM = self.realScoreDetail.scoreDetail;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pTotalScore.doubleValue];
    [self.districtRankBtn setNormalTitle:[NSString stringWithFormat:@"第%@名", scoreDetailM.pAreaRanking]];
    [self.provinceRankBtn setNormalTitle:[NSString stringWithFormat:@"第%@名", scoreDetailM.pProvinceRanking]];
    [self.cityRankBtn setNormalTitle:[NSString stringWithFormat:@"第%@名", scoreDetailM.pCityRanking]];
    self.prideShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pBrcScore.floatValue];
    self.perfectShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pPreScore.floatValue];
    self.adventureScore.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pStadyScore.floatValue];
    self.prideSmallView.yh_width = self.prideBigView.yh_width * scoreDetailM.pBcrRate.doubleValue;
    self.perfectSmallView.yh_width = self.prideBigView.yh_width * scoreDetailM.pPreRate.doubleValue;

    self.totalScoreSmallView.yh_width = self.prideBigView.yh_width * scoreDetailM.pTotalRate.doubleValue;
    
    self.prideScoreChangeBtn.selected = scoreDetailM.pBrcScoreChange.integerValue == -1;
    self.huaMountainChangeBtn.selected = scoreDetailM.pPreScoreChange.integerValue == -1;
    self.studyChangeBtn.selected = scoreDetailM.pStadyScoreChange.integerValue == -1;
    
    ///分数变化
    self.prideScoreChangeBtn.selected = scoreDetailM.pBrcScoreChange.integerValue == -1;
    self.huaMountainChangeBtn.selected = scoreDetailM.pPreScoreChange.integerValue == -1;
    self.studyChangeBtn.selected = scoreDetailM.pStadyScoreChange.integerValue == -1;
}

- (IBAction)prideUploadPicAction:(UIButton *)sender {
    YHFunc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHUploadPicPrideVC class]) bundle:nil];
    YHUploadPicPrideVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

- (IBAction)huaShSwordUploadPicAction:(UIButton *)sender {
    
    [self uploadPicOfHuaShanSwordAction];
    
}

- (IBAction)studyHistoryAction:(id)sender {
    
}

- (IBAction)studyAction:(UIButton *)sender {
    
    
}

- (IBAction)appellationAction:(UIButton *)sender {
    [self appellationClickAction];
}

//查看已上传图片
- (IBAction)seePrideUploadedPicAction:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSeePrideUploadedVC class]) bundle:nil];
    YHSeePrideUploadedVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

//查看已上传图片
- (IBAction)seeHuaShanUploadedPicAction:(UIButton *)sender {
    [self seeUploadedImagesAction];
}


- (IBAction)prideAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHFindErrorVC class]) bundle:nil];
    YHFindErrorVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

//论剑
- (IBAction)swordAction:(UIButton *)sender {

    [self swordGameSongAction];
}

///第二层下部view的手势事件
- (IBAction)jumpToMyRanking:(UITapGestureRecognizer *)tapGes {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHMyRankingVC class]) bundle:nil];
    YHMyRankingVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

//点击 '奖'事件
- (IBAction)prizeAction:(UIButton *)sender {
    //父类方法
    [self prizeClickAction];
}


@end
