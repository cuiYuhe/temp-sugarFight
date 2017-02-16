//
//  YHSugarFightAverageHomeVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightAverageHomeVc.h"
#import "YHUploadPicActivityVc.h"
#import "YHPrizeListVc.h"

@implementation YHSugarFightAverageHomeVc

- (void)viewDidLoad{
    
}

#pragma mark ------------------------------------------
#pragma mark publick methods 子类继承的方法
- (void)settingActionWithRealScoreDetail:(YHRealScoreDetailModel *)realScoreDetail{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHLoginOffVC class]) bundle:nil];
    YHLoginOffVC *vc = [sb instantiateInitialViewController];
    vc.realScoreDetailM = realScoreDetail;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
}

- (void)dailySignInAction{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHDailySignInVC class]) bundle:nil];
    YHDailySignInVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///点击'论剑'事件
- (void)swordGameSongAction{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSwordSongVc class]) bundle:nil];
    YHSwordSongVc *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///点击查看已上传的图片事件
- (void)seeUploadedImagesAction{
    YHSeeUploadSwordGrideImgVc *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHSeeUploadSwordGrideImgVc class])];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///华山论剑上传图片
- (void)uploadPicOfHuaShanSwordAction{
    //    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHUploadPicPerfectShopVC class]) bundle:nil];
    //    YHUploadPicPerfectShopVC *vc = [sb instantiateInitialViewController];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHUploadPicActivityVc class]) bundle:nil];
    YHUploadPicActivityVc *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///左下角我的称谓点击事件
- (void)appellationClickAction{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHMyApplellationVC class]) bundle:nil];
    YHMyApplellationVC *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
    YHScoreDetailModel *scoreDetailM = self.realScoreDetail.scoreDetail;
    vc.prideTotalScore = scoreDetailM.brcScore.doubleValue;
    vc.huaShanTotalScore = scoreDetailM.preScore.doubleValue;
}

///下方 '奖' 点击事件
- (void)prizeClickAction{
    YHPrizeListVc *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHPrizeListVc class])];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}


@end
