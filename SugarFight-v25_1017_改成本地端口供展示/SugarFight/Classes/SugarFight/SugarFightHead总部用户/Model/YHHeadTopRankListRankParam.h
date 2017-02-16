//
//  YHRankListRankParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHeadTopRankListRankParam : NSObject

/** 区域id,1234代表东南西北区 */
@property (nonatomic, assign) NSInteger areaId;
/** 用户类型	TT/WS/ISM  */
@property (nonatomic, strong) NSString *userWay;
/** 查询的是本P的排名还是总计的排名	TOTAL:总计; BENP:本P */
@property (nonatomic, strong) NSString *totalOrBenP;
@end
