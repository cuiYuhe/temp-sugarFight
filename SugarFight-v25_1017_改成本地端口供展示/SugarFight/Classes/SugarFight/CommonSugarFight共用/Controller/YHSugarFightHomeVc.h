//
//  YHSugarFightHomeVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"

@interface YHSugarFightHomeVc : YHViewController

/**
 *  加载所有的标题
 */
- (void)loadAllTitlesWithSuccess:(void (^)(YHTitlesResult *titlesM))success failure:(void (^)(NSError *error))failure;

@end
