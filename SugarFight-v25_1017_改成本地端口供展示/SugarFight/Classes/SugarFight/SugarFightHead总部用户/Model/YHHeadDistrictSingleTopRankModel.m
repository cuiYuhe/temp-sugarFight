//
//  YHDistrictSingleRankModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHHeadDistrictSingleTopRankModel.h"

@implementation YHHeadDistrictSingleTopRankModel

- (void)setUserScore:(NSString *)userScore{
    _userScore = [NSString stringWithFormat:@"%.1f", userScore.floatValue];
}
@end
