//
//  YHDistrictHeroModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHSingleRankModel.h"

@interface YHDistrictHeroModel : NSObject

/** ismRank	英雄榜信息的ism榜 */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *ismRank;
/** ttRank	英雄榜信息的tt榜 */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *ttRank;
/** wsRank	英雄榜信息的ws榜 */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *wsRank;

@end
