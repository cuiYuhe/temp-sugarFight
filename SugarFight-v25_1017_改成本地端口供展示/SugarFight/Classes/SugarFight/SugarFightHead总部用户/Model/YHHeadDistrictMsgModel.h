//
//  YHDistrictMsgModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHDistrictType) {
    /** 区域id,1234代表东南西北区 */
    YHDistrictTypeEast = 1,
    YHDistrictTypeSouth,
    YHDistrictTypeWest,
    YHDistrictTypeNorth,
};

@interface YHHeadDistrictMsgModel : NSObject

/** 区域活跃度 */
@property (nonatomic, strong) NSString *activeness;
/** 区域id,1234代表东南西北区 */
@property (nonatomic, assign) YHDistrictType areaId;
/** 区域名称 */
@property (nonatomic, strong) NSString *areaName;

/**  */
@property (nonatomic, strong) NSNumber *onLineUser;
/**  */
@property (nonatomic, strong) NSString *ruWei;
/**  */
@property (nonatomic, strong) NSNumber *totalUser;
@end
