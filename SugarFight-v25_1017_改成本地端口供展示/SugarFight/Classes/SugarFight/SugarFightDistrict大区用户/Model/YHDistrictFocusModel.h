//
//  YHDistricInfoModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDistrictFocusModel : NSObject
/** activeness */
@property (nonatomic, strong) NSString *activeness;
/** areaId */
@property (nonatomic, strong) NSNumber *areaId;
/** areaName */
@property (nonatomic, strong) NSString *areaName;
/** onLineUser */
@property (nonatomic, strong) NSNumber *onLineUser;
/** ruWei */
@property (nonatomic, strong) NSNumber *ruWei;
/** totalUser */
@property (nonatomic, strong) NSNumber *totalUser;

@end

