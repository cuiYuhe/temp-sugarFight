//
//  YHDistrictTopRankCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDistrictTopRankCell.h"
#import "YHHeadDistrictSingleTopRankModel.h"

@implementation YHDistrictTopRankCell

- (void)setRankM:(YHHeadDistrictSingleTopRankModel *)rankM{
    _rankM = rankM;
    YHThreeDataCellModel *model = [[YHThreeDataCellModel alloc] init];
    model.leftData = rankM.userName;
    model.midData = rankM.province;
    model.rightData = rankM.userScore;
    self.model = model;
}

@end
