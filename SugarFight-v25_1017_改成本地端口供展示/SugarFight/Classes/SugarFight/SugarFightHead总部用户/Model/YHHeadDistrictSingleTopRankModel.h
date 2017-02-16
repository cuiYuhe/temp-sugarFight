//
//  YHDistrictSingleRankModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHeadDistrictSingleTopRankModel : NSObject

/** aRank */
@property (nonatomic, strong) NSNumber *aRank;
/** cRank */
@property (nonatomic, strong) NSNumber *cRank;
/** city */
@property (nonatomic, strong) NSString *city;
/** largeArea */
@property (nonatomic, strong) NSString *largeArea;
/** pRank */
@property (nonatomic, strong) NSNumber *pRank;
/** province */
@property (nonatomic, strong) NSString *province;
/** userAvatar */
@property (nonatomic, strong) NSString *userAvatar;
/** userAvatarId */
@property (nonatomic, strong) NSNumber *userAvatarId;
/** userId */
@property (nonatomic, strong) NSNumber *userId;
/** userLevel */
@property (nonatomic, strong) NSString *userLevel;
/** userLevelId */
@property (nonatomic, strong) NSNumber *userLevelId;
/** userName */
@property (nonatomic, strong) NSString *userName;
/** userScore */
@property (nonatomic, strong) NSString *userScore;

@end
