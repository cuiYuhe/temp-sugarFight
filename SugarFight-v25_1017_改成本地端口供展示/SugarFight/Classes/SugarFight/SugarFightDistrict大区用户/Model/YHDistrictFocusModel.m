//
//  YHDistricInfoModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDistrictFocusModel.h"

@implementation YHDistrictFocusModel

- (void)setActiveness:(NSString *)activeness{
    _activeness = [NSString stringWithFormat:@"%@%%", activeness];
}
@end
