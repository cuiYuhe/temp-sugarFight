//
//  YHDistrictFocusCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/15.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDistrictFocusCell.h"

@implementation YHDistrictFocusCell

- (void)setFocusM:(YHDistrictFocusModel *)focusM{
    _focusM = focusM;
    YHThreeDataCellModel *model = [[YHThreeDataCellModel alloc] init];
    model.leftData = focusM.areaName;
    model.midData = focusM.activeness;
    model.rightData = focusM.ruWei.stringValue;
    self.model = model;
}

@end
