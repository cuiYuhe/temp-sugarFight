//
//  YHDistrictHomeParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/23.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDistrictHomeParam : NSObject
/**	用户id */
@property (nonatomic, strong) NSNumber *uid;
/** 查询的是本P的排名还是总计的排名	TOTAL:总计; BENP:本P */
@property (nonatomic, strong) NSString *totalOrBenP;

@end
