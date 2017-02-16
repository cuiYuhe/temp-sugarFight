//
//  YHProviceSingleRankModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"

@interface YHProvinceSingleRankModel : YHBaseModel

/** userId	用户id */
@property (nonatomic, strong) NSNumber *userId;
/** userName	用户名 */
@property (nonatomic, strong) NSString *userName;
/** "userAvatarId": 14, */
@property (nonatomic, strong) NSNumber *userAvatarId;
/** userAvatar	用户头像 */
@property (nonatomic, strong) NSString *userAvatar;
/** userLevel	用户等级 */
@property (nonatomic, strong) NSString *userLevel;
/** "userLevelId": 15, */
@property (nonatomic, strong) NSNumber *userLevelId;
/** userScore	用户得分 */
@property (nonatomic, strong) NSNumber *userScore;
/** cRank	城市排名 */
@property (nonatomic, strong) NSNumber *cRank;
/** pRank	省排名 */
@property (nonatomic, strong) NSNumber *pRank;
/** aRank	大区排名 */
@property (nonatomic, strong) NSNumber *aRank;
/** largeArea	所在大区 */
@property (nonatomic, strong) NSString *largeArea;
/** province	所在省份 */
@property (nonatomic, strong) NSString *province;
/** city	所在城市 */
@property (nonatomic, strong) NSString *city;

@end





