//
//  YHCommonDataTool.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSeeUploadCommenVc;

typedef NS_ENUM(NSInteger, YHChannelType){
    YHChannelTypeTT,
    YHChannelTypeISM,
    YHChannelTypeWS,
};


typedef NS_ENUM(NSInteger, YHPType){
    YHPTypeTotal,
    YHPTypeThisP,
    
    ///实际中没有这个选项,传入这个时,表明要有其它的操作
    YHPTypeOther,
};

///AREA:大区排名; PROVINCE:省排名; CITY:城市排名
typedef NS_ENUM(NSInteger, YHRankLevelType){
    YHRankLevelTypeCity,
    YHRankLevelTypeProvince,
    YHRankLevelTypeArea,
};

///称谓
typedef NS_ENUM(NSInteger, YHUserLevelType) {
    YHUserLevelTypeXinXiu = 1,
    YHUserLevelTypeShaoXia,
    YHUserLevelTypeGaoShou,
    YHUserLevelTypeHaojie,
    YHUserLevelTypeZongshi,
};

@interface YHCommonDataTool : NSObject
SingleH(CommonDataTool)

- (NSString *)getChannelWithChannelType:(YHChannelType)channelType;
- (NSString *)getSelectPWithpType:(YHPType)pType;
///AREA:大区排名; PROVINCE:省排名; CITY:城市排名
- (NSString *)getSelectRankLevelWithpType:(YHRankLevelType)rankLevelType;
///获得称谓
- (NSString *)getUserLevelWithUserLevel:(YHUserLevelType)userLevel;

/**
 *  得到哪个查看上传图片的vc
 *
 *  @param category 类型YHCategoryType
 *
 *  @return 查看图片的vc
 */
- (YHSeeUploadCommenVc *)getSeeUploadPicVcWithCategory:(YHCategoryType)category;

@end
