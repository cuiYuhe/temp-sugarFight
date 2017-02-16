//
//  YHWinnerListResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHWinnerSingleM.h"

@interface YHWinnerListResult : YHBaseModel

/** 中奖信息列表 */
@property (nonatomic, strong) NSArray<YHWinnerSingleM *> *lotterySuccess;
@end
