//
//  YHRankListRankResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHHeadTopRankListRankResult.h"

@implementation YHHeadTopRankListRankResult
MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rank" : [YHHeadDistrictSingleTopRankModel class]};
}
@end
