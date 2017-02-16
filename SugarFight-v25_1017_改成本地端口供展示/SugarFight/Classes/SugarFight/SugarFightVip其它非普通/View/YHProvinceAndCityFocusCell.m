//
//  YHProvinceAndCityHeroCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHProvinceAndCityFocusCell.h"
#import "YHLoginModel.h"

@implementation YHProvinceAndCityFocusCell

- (void)setRankM:(YHSingleRankModel *)rankM{
    _rankM = rankM;
    YHThreeDataCellModel *model = [[YHThreeDataCellModel alloc] init];
    model.leftData = rankM.userName;
    model.midData = rankM.province;
    
    //省vip是省排名;市vip是市排名
    YHVipLevelType vipLevel = [GlobeSingle shareGlobeSingle].loginM.vipLevel;
    if (vipLevel == YHVipLevelTypeProvince) {//省vip
        model.rightData = rankM.pRank.stringValue;
    }else if(vipLevel == YHVipLevelTypeCity){//市vip
        model.rightData = rankM.cRank.stringValue;
    }
    self.model = model;
}

@end
