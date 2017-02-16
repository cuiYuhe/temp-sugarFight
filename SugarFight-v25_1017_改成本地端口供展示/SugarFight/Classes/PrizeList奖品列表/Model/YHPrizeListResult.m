//
//  YHPrizeListResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPrizeListResult.h"

@implementation YHPrizeListResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"gifts" : [YHPrizeSubGiftModel class]};
}
@end
