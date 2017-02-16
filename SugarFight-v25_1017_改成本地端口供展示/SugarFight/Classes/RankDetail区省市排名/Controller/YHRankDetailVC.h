//
//  YHRankDetailVC.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
@class YHProvinceRankListParam;

@interface YHRankDetailVC : YHViewController
/** title */
@property (nonatomic, copy) NSString *titleOfTop;
/** YHProvinceRankListParam */
@property (nonatomic, strong) YHProvinceRankListParam *paramForRankList;
@end
