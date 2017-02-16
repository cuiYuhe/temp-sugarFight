//
//  YHLoginDataUserModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/26.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHLoginDataUserModel.h"

@implementation YHLoginDataUserModel
- (void)setUserLevelId:(YHUserLevelType)userLevelId{
    _userLevelId = userLevelId - 14;
    _userLevel = [[YHCommonDataTool shareCommonDataTool] getUserLevelWithUserLevel:_userLevelId];
}

@end
