//
//  YHCurrentDistrictModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHDistrictHeroModel.h"
#import "YHDistrictFocusModel.h"

@interface YHDistrictHomeResult : YHBaseModel
/** heroRankMsg	英雄榜信息 */
@property (nonatomic, strong) YHDistrictHeroModel *heroRankMsg;
/** areaMsg	大区下的'重点关注'信息 */
@property (nonatomic, strong) NSArray<YHDistrictFocusModel *> *areaMsg;


@end

