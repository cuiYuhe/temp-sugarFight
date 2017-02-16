//
//  YHDistrictHeroCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/15.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDistrictHeroCell.h"

@implementation YHDistrictHeroCell

- (void)setRankM:(YHSingleRankModel *)rankM{
    _rankM = rankM;
    YHThreeDataCellModel *model = [[YHThreeDataCellModel alloc] init];
    model.leftData = rankM.userName;
    model.midData = rankM.province;
    model.rightData = rankM.aRank.stringValue;
    self.model = model;
}

@end
