//
//  YHDistrictMsgModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHHeadDistrictMsgModel.h"

@implementation YHHeadDistrictMsgModel
MJLogAllIvars

- (void)setActiveness:(NSString *)activeness{
    _activeness = [NSString stringWithFormat:@"%@%%", activeness];
}
@end
