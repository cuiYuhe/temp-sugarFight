//
//  YHRankListRankResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHHeadDistrictSingleTopRankModel.h"

@interface YHHeadTopRankListRankResult : YHBaseModel
/** ranks array , */
@property (nonatomic, strong) NSArray<YHHeadDistrictSingleTopRankModel *> *rank;


@end
