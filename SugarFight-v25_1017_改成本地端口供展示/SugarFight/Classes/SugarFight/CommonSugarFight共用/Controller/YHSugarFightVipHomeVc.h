//
//  YHSugarFightVipHomeVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/23.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
#import "YHPrideAndSwordVipTabBar.h"
#import "YHCommonDataTool.h"
#import "YHSugarFightHomeVc.h"

///vip用户继承的vc
@interface YHSugarFightVipHomeVc : YHSugarFightHomeVc

/** 下部自定义view */
@property (weak, nonatomic) YHPrideAndSwordVipTabBar *tabBar;
/** 选中的本p,还是累计 */
@property (nonatomic, copy) NSString *pChosen;

///留给子类实现,当切换'累计','本p' 这两个选择的p时,重新加载相应的数据
- (void)loadNewDataAfterShiftingP;

///子类必须调用super
- (void)setup;

@end
