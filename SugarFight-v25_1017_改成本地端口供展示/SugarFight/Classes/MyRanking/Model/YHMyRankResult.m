//
//  YHMyRankResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHMyRankResult.h"

@implementation YHMyRankResult
MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rankMsg" : [YHSingleRankModel class]};
}
@end
