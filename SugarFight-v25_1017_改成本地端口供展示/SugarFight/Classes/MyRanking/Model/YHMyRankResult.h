//
//  YHMyRankResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHSingleRankModel.h"

@interface YHMyRankResult : YHBaseModel
/** 当前页 */
@property (nonatomic, strong) NSNumber *currentPage;
/** YHSingleRankModel array */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *rankMsg;

@end
