//
//  YHProvinceRankListResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHSingleRankModel.h"

/** 27.根据条件查询排名/Msg/queryRankMsg */
@interface YHProvinceRankListResult : YHBaseModel

/** rankMsg	排名信息 */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *rankMsg;
@end
