//
//  YHSingleRankModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
///获得排名信息时,单个排名的属性,13个.
@interface YHSingleRankModel : NSObject

/** aRank, 大区排名 */
@property (nonatomic, strong) NSNumber *aRank;
/** cRank, 城市排名 */
@property (nonatomic, strong) NSNumber *cRank;
/** city */
@property (nonatomic, strong) NSString *city;
/** largeArea 南区*/
@property (nonatomic, strong) NSString *largeArea;
/** pRank, 省份排名 */
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
@property (nonatomic, strong) NSNumber *userScore;

@end
