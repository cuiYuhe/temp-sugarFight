//
//  YHProvinceRankListParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

///27.根据条件查询排名/Msg/queryRankMsg
@interface YHProvinceRankListParam : NSObject

/** areaId	Integer	用户所在大区id	2，登录接口有返回这个id */
@property (nonatomic, strong) NSNumber *areaId;
/** 查询的是本P的排名还是总计的排名	TOTAL:总计;BENP:本P */
@property (nonatomic, strong) NSString *totalOrBenP;
/** 用户渠道	TT.ISM.WS */
@property (nonatomic, strong) NSString *userWay;
/** 当前页,用于分页 */
@property (nonatomic, strong) NSNumber *currentPage;
/** 每页的条数,	用于分页 */
@property (nonatomic, strong) NSNumber *pageSize;


@end
