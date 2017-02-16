//
//  YHDistrctDetailParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDistrictDetailParam : NSObject

/** 查询的是本P的排名还是总计的排名	TOTAL:总计; BENP:本P */
@property (nonatomic, strong) NSString *totalOrBenP;
/** 区域id,1234代表东南西北区 */
@property (nonatomic, assign) NSNumber *areaId;

@end
