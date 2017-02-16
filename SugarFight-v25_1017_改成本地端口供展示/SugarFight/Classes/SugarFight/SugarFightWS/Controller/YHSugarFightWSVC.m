//
//  YHSugarFightWSVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightWSVC.h"
#import "YHUploadPicPerfectShopVC.h"
#import "YHProgressBorderView.h"
#import "YHSeeHuaShanUploadedVC.h"

static NSString *const YHStrUrlGetRealScoreDetail = @"jianpai/User/getRealScoreDetail";

@interface YHSugarFightWSVC ()
/** 排名 得分 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *districtRankLabel;
@property (weak, nonatomic) IBOutlet UIButton *provinceRankLabel;
@property (weak, nonatomic) IBOutlet UIButton *cityRankLabel;
/** 华山论剑得分 */
@property (weak, nonatomic) IBOutlet UILabel *perfectShopScoreLabel;
/** 闭关修炼得分 */
@property (weak, nonatomic) IBOutlet UILabel *adventureScore;
/** 华山论剑 进度条 */
@property (weak, nonatomic) IBOutlet UIView *perfectSmallView;
@property (weak, nonatomic) IBOutlet YHProgressBorderView *perfectBigView;

/** 左下角的等级图片,需要切换:efficacy_01 */
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
/** 累计结果按钮 */
@property (weak, nonatomic) IBOutlet UIButton *totalResultBtn;
/** 本P结果按钮 */
@property (weak, nonatomic) IBOutlet UIButton *thisPBtn;

/** 标识 华山论剑 分数变化 */
@property (weak, nonatomic) IBOutlet UIButton *huaMountainChangeBtn;
/** 标识 闯关修炼 分数变化 */
@property (weak, nonatomic) IBOutlet UIButton *studyChangeBtn;

/** 标题-华山论剑 */
@property (weak, nonatomic) IBOutlet UIImageView *titleGameImgView;
/** 标题-闯关修炼 */
@property (weak, nonatomic) IBOutlet UIImageView *titleStudyImgView;
/** 标题-功力指数 */
@property (weak, nonatomic) IBOutlet UIImageView *titleScoreImgView;


@end

@implementation YHSugarFightWSVC

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
    
    //efficacy_01
    NSString *imgName = [NSString stringWithFormat:@"efficacy_0%zd", [GlobeSingle shareGlobeSingle].loginM.data.user.userLevelId];
    [self.levelBtn setNormalBackgroundImage: imgName];
}

//加载标题
- (void)getTitles{
    [self loadAllTitlesWithSuccess:^(YHTitlesResult *titlesM) {
        
        //设置标题图片
        [titlesM setTitleImageWithTitleType:YHTitleTypeHomepage_battle titleImageView:self.titleGameImgView];
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
            [MBProgressHUD showError:self.realScoreDetail.message];
            return ;
        }
        self.realScoreDetail = [YHRealScoreDetailModel mj_objectWithKeyValues:responseObj];
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
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.totalScore.doubleValue];
    self.scoreLabel.font = YHFontFZHuangCao(30);
    
    void (^setupBtn)(UIButton *btn, NSNumber *num, CGFloat fontSize) = ^(UIButton *btn, NSNumber *num, CGFloat fontSize){
        [btn setNormalTitle:[NSString stringWithFormat:@"第%@名", num]];
        btn.titleLabel.font = YHFontFZHuangCao(fontSize);

    };
    
    CGFloat fontSize = 14.0f;
    if (YHScreenW >= 375.0f) {//iphone6及以上的宽度
        fontSize = 18.0f;
    }
    setupBtn(self.districtRankLabel, scoreDetailM.areaRanking, fontSize);
    setupBtn(self.provinceRankLabel, scoreDetailM.provinceRanking, fontSize);
    setupBtn(self.cityRankLabel, scoreDetailM.cityRanking, fontSize);
    
    self.perfectShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.preScore.floatValue];
        self.adventureScore.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.stadyScore.doubleValue];
    
    self.perfectSmallView.yh_width = self.perfectBigView.yh_width * scoreDetailM.preRate.doubleValue;
    
    ///分数变化
    self.huaMountainChangeBtn.selected = scoreDetailM.preScoreChange.integerValue == -1;
    self.studyChangeBtn.selected = scoreDetailM.stadyScoreChange.integerValue == -1;
}

- (IBAction)thisPAction:(UIButton *)sender {
    YHFunc
    sender.selected = YES;
    self.totalResultBtn.selected = NO;
    
    //更新相应控件的值
    YHScoreDetailModel *scoreDetailM = self.realScoreDetail.scoreDetail;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pTotalScore.floatValue];
    [self.districtRankLabel setNormalTitle:[NSString stringWithFormat:@"第%@名", scoreDetailM.pAreaRanking]];
    [self.provinceRankLabel setNormalTitle:[NSString stringWithFormat:@"第%@名", scoreDetailM.pProvinceRanking]];
    [self.cityRankLabel setNormalTitle:[NSString stringWithFormat:@"第%@名", scoreDetailM.pCityRanking]];
    self.perfectShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pBrcScore.floatValue];
    self.perfectShopScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.pPreScore.floatValue];
    self.adventureScore.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.stadyScore.floatValue];
    self.perfectSmallView.yh_width = self.perfectBigView.yh_width * scoreDetailM.pPreRate.doubleValue;
    
    ///分数变化
    self.huaMountainChangeBtn.selected = scoreDetailM.pPreScoreChange.integerValue == -1;
    self.studyChangeBtn.selected = scoreDetailM.pStadyScoreChange.integerValue == -1;
}

- (IBAction)uploadPicAction:(UIButton *)sender {
    YHFunc
    [self uploadPicOfHuaShanSwordAction];
}

- (IBAction)perfectShopHistoryAction:(UIButton *)sender {
    
    YHLog(@"history暂未做");
}

//查看已上传图片
- (IBAction)seeHuaShanUploadedPicAction:(UIButton *)sender {
    [self seeUploadedImagesAction];
    
}

//跳到选对错界面
- (IBAction)swordGameAction:(id)sender {
    
    [self swordGameSongAction];
}

- (IBAction)studyAction:(UIButton *)sender {
    
}

- (IBAction)appellationAction:(UIButton *)sender {
    [self appellationClickAction];
}

///第二层下部view的手势事件
- (IBAction)jumpToMyRanking:(UITapGestureRecognizer *)tapGes {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHMyRankingVC class]) bundle:nil];
    YHMyRankingVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

- (IBAction)prizeAction:(UIButton *)sender {
    //父类方法
    [self prizeClickAction];
}



@end
