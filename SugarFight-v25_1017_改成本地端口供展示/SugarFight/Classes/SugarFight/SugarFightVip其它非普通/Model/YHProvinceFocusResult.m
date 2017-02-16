//
//  YHProvinceFocusResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHProvinceFocusResult.h"

@implementation YHProvinceFocusResult
MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"ismRankMsg" : [YHSingleRankModel class],
             @"ttRankMsg" : [YHSingleRankModel class],
             @"wsRankMsg" : [YHSingleRankModel class],
             };
}

@end
