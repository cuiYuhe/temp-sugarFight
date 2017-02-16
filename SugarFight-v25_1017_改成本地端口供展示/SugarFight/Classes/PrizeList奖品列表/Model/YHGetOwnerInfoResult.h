//
//  YHGetOwnerInforResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
@class YHPrizeSubReceiverModel;

@interface YHGetOwnerInfoResult : YHBaseModel

/** YHPrizeSubReceiverModel */
@property (nonatomic, strong) YHPrizeSubReceiverModel *receiver;

@end
