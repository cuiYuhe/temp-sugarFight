//
//  YHSingleRankModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSingleRankModel.h"

@implementation YHSingleRankModel

- (void)setProvince:(NSString *)province{
    
    if ([province hasSuffix:@"省"]) {
        province = [province substringToIndex:province.length - 1];
    }
    _province = province;
}

@end
