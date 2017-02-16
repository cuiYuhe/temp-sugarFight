//
//  YHWinnerListResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHWinnerListResult.h"

@implementation YHWinnerListResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"lotterySuccess" : [YHWinnerSingleM class]};
}
@end
