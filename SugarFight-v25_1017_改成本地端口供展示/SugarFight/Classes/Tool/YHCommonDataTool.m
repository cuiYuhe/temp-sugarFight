//
//  YHCommonDataTool.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommonDataTool.h"
#import "YHSeeHuaShanUploadedVC.h"
#import "YHSeePrideUploadedVC.h"
#import "YHSeeUploadSwordGrideImgVc.h"

@interface YHCommonDataTool()
/** channels */
@property (nonatomic, strong) NSArray *channels;
/** p数组:累计,本p */
@property (nonatomic, strong) NSArray *ps;
///AREA:大区排名; PROVINCE:省排名; CITY:城市排名
@property (nonatomic, strong) NSArray *rankLevels;
/** 称谓 */
@property (nonatomic, strong) NSArray *userLevels;

@end

@implementation YHCommonDataTool
SingleM(CommonDataTool)

#pragma mark ------------------------------------------
#pragma mark lazy
- (NSArray *)channels{
    if (!_channels) {
        _channels = @[@"TT", @"ISM", @"WS"];
    }
    return _channels;
}

- (NSArray *)ps{
    if (!_ps) {
        _ps = @[@"TOTAL", @"BENP",@"OTHER"];
    }
    return _ps;
}

- (NSArray *)rankLevels{
    if (!_rankLevels) {
        _rankLevels = @[@"CITY", @"PROVINCE", @"AREA"];
    }
    return _rankLevels;
}

- (NSArray *)userLevels{
    if (!_userLevels) {
        _userLevels = @[@"新秀", @"少侠", @"高手", @"豪杰", @"宗师"];
    }
    return _userLevels;
}


#pragma mark ------------------------------------------
#pragma mark external method
- (NSString *)getChannelWithChannelType:(YHChannelType)channelType{
    
    return self.channels[channelType];
}

- (NSString *)getSelectPWithpType:(YHPType)pType{
    return self.ps[pType];
}

///AREA:大区排名; PROVINCE:省排名; CITY:城市排名
- (NSString *)getSelectRankLevelWithpType:(YHRankLevelType)rankLevelType{
    return self.rankLevels[rankLevelType];
}

///获得称谓
- (NSString *)getUserLevelWithUserLevel:(YHUserLevelType)userLevel{
    //因为这个枚举的值是从1开始
    return self.userLevels[userLevel - 1];
}

- (YHSeeUploadCommenVc *)getSeeUploadPicVcWithCategory:(YHCategoryType)category{
    switch (category) {
        case YHCategoryTypeHuaShanPerfect:{
            return [[YHSeeHuaShanUploadedVC alloc] init];
        }
            break;
        case YHCategoryTypePrideBcr:{
            return [[YHSeePrideUploadedVC alloc] init];
        }
            break;
        case YHCategoryTypeBattleGridImages:{
            return [[YHSeeUploadSwordGrideImgVc alloc] init];
        }
            break;
            
        default:
            break;
    }
}

@end
