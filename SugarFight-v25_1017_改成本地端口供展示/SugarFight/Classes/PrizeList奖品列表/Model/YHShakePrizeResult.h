//
//  YHShakePrizeResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHPrizeSubReceiverModel.h"
#import "YHPrizeSubGiftModel.h"

@interface YHShakePrizeResult : YHBaseModel

/** YHPrizeSubGiftModel */
@property (nonatomic, strong) YHPrizeSubGiftModel *gift;

/** 抽奖结果：1抽中，0未抽中 */
@property (nonatomic, assign, getter=isLotteryStatus) BOOL lotteryStatus;

/** YHPrizeSubReceiverModel */
@property (nonatomic, strong) YHPrizeSubReceiverModel *receiver;


@end
