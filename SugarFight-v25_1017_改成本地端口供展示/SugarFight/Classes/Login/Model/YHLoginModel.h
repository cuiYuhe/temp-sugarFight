//
//  YHLoginModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/26.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHLoginDataModel.h"
#import "YHScoreDetailModel.h"

typedef NS_ENUM(NSInteger, YHVipLevelType) {
    YHVipLevelTypeCommon,
    YHVipLevelTypeNation,
    YHVipLevelTypeDistrict,
    YHVipLevelTypeProvince,
    YHVipLevelTypeCity,
};

@interface YHLoginModel : NSObject

/** data */
@property (nonatomic, strong) YHLoginDataModel *data;
/** loginStatus, 0第一次登录,1三天内登录,2三天以上登录 */
@property (nonatomic, strong) NSNumber *loginStatus;
/** message,UUID */
@property (nonatomic, strong) NSString *message;
/** show, 是否弹出数据0,暂时不用 */
@property (nonatomic, strong) NSNumber *scoreChange;
/** scoreDetail,首页及我的称谓的分数数据 */
@property (nonatomic, strong) YHScoreDetailModel *scoreDetail;
/** status, 1代表成功 */
@property (nonatomic, strong) NSNumber *status;
/** userArea,地区 */
@property (nonatomic, strong) NSString *userArea;
/** userWay,用户渠道,如WS代表'WS'用户,其它为非'WS'用户 */
@property (nonatomic, strong) NSString *userWay;
/** vipLevel,0:普通用户;1:全国 2.大区 3.省 4:城市 */
@property (nonatomic, assign) YHVipLevelType vipLevel;
/** userLargeAreaId,请求大区信息时使用 */
@property (nonatomic, strong) NSNumber *userLargeAreaId;

@end






