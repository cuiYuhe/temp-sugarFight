//
//  YHProvinceRankListResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHProvinceRankListResult.h"

@implementation YHProvinceRankListResult

MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"rankMsg" : [YHSingleRankModel class]};
}
@end
