//
//  YHProvinceFocusParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHProvinceFocusParam : NSObject

/** areaId	Integer	用户所在大区id	2，登录接口有返回这个id */
@property (nonatomic, strong) NSNumber *areaId;
/** 查询的是本P的排名还是总计的排名	TOTAL:总计;BENP:本P */
@property (nonatomic, strong) NSString *totalOrBenP;

@end
