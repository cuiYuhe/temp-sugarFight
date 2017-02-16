//
//  YHSugarFightAverageHomeVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
#import "YHSwordSongVc.h"
#import "YHMyRankingVC.h"
#import "YHChooseTFVC.h"
#import "YHLoginOffVC.h"
#import "YHLoginModel.h"
#import "YHRealScoreDetailModel.h"
#import "YHMyApplellationVC.h"
#import "YHPopViewUploaded.h"
#import "YHDailySignInVC.h" //每日签到
#import "YHSeeUploadSwordGrideImgVc.h"
#import "YHSugarFightHomeVc.h"

@interface YHSugarFightAverageHomeVc : YHSugarFightHomeVc

/** YHRealScoreDetailModel model,中有scoreDetail模型 */
@property (nonatomic, strong) YHRealScoreDetailModel *realScoreDetail;








///点击 setting 的事件
- (void)settingActionWithRealScoreDetail:(YHRealScoreDetailModel *)realScoreDetail;

///点击每日签到事件
- (void)dailySignInAction;

///点击'论剑'事件
- (void)swordGameSongAction;

///点击查看已上传的图片事件
- (void)seeUploadedImagesAction;

///华山论剑上传图片
- (void)uploadPicOfHuaShanSwordAction;

///左下角我的称谓点击事件
- (void)appellationClickAction;

///下方 '奖' 点击事件
- (void)prizeClickAction;










@end
