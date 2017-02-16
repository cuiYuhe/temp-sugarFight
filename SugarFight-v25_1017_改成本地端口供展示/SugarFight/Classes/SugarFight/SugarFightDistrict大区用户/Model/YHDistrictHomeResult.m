//
//  YHCurrentDistrictModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDistrictHomeResult.h"

@implementation YHDistrictHomeResult
MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"areaMsg" : [YHDistrictFocusModel class]};
}
@end
