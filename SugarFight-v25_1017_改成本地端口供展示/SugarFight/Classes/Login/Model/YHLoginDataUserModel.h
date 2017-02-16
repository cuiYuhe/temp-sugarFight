//
//  YHLoginDataUserModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/26.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCommonDataTool.h"

@interface YHLoginDataUserModel : NSObject


/** lastScore */
@property (nonatomic, strong) NSNumber *lastScore;
/** socialName,姓名 */
@property (nonatomic, strong) NSString *socialName;
/** userAreaId,返回为nil,区域ID */
@property (nonatomic, strong) NSNumber *userAreaId;
/** userAvatarId,头像ID */
@property (nonatomic, strong) NSNumber *userAvatarId;
/** userId */
@property (nonatomic, strong) NSNumber *userId;
/** userLevelId, 15-19,为了枚举,及主页设置等级图片,重写了set方法,-14 */
@property (nonatomic, assign) YHUserLevelType userLevelId;
/** 添加的属性,称谓 */
@property (nonatomic, strong) NSString *userLevel;
/** userName */
@property (nonatomic, strong) NSString *userName;
/** userPwd */
@property (nonatomic, strong) NSString *userPwd;
/** userTel */
@property (nonatomic, strong) NSString *userTel;
/** userWayId,渠道ID */
@property (nonatomic, strong) NSNumber *userWayId;

@end


