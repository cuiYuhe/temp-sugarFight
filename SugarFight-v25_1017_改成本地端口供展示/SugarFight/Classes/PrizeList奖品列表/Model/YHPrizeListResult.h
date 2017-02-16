//
//  YHPrizeListResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHPrizeSubGiftModel.h"
#import "YHPrizeSubReceiverModel.h"

@interface YHPrizeListResult : YHBaseModel

/** YHPrizeSubGiftModel数组 */
@property (nonatomic, strong) NSArray<YHPrizeSubGiftModel *> *gifts;

/** 是否有地址信息,1有,0无 */
@property (nonatomic, assign, getter=isHasRecever) BOOL hasRecever;

/** 地址信息 */
@property (nonatomic, strong) YHPrizeSubReceiverModel *receiver;
@end
