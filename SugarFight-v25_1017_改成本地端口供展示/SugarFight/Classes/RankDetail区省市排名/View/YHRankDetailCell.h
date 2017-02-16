//
//  YHRankDetailCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSingleRankModel;

@interface YHRankDetailCell : UITableViewCell

/** YHSingleRankModel */
@property (nonatomic, strong) YHSingleRankModel *rankM;

+ (NSString *)identifier;
@end
