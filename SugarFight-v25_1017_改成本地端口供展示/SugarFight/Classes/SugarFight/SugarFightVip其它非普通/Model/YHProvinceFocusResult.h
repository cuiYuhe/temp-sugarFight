//
//  YHProvinceFocusResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHSingleRankModel.h"

@interface YHProvinceFocusResult : YHBaseModel

/** ismRankMsg */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *ismRankMsg;
/** ttRankMsg */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *ttRankMsg;
/** wsRankMsg */
@property (nonatomic, strong) NSArray<YHSingleRankModel *> *wsRankMsg;

   
@end
