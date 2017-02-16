//
//  YHMyRankingCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSingleRankModel;
#import "YHCommonDataTool.h"

@interface YHMyRankingCell : UITableViewCell

/** YHMyRankResult model */
@property (nonatomic, strong) YHSingleRankModel *rankM;
/** 用户选择的是哪个类别,需要显示对应的aRank,cRank,pRank */
@property (nonatomic, assign) YHRankLevelType selectedLevelType;

+ (NSString *)identifier;
@end
