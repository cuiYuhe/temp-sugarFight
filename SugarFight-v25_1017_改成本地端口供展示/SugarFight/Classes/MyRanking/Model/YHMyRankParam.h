//
//  YHMyRankParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"

//暂时未用这个view
@interface YHMyRankParam : YHBaseModel

/** uid	Integer	用户id	13 */
@property (nonatomic, strong) NSNumber *uid;
/** userWay	String	用户类型	TT.ISM.WS */
@property (nonatomic, strong) NSString *userWay;
/** totalOrBenP	String	总计还是本P	TOTAL:总计;BENP:本P */
@property (nonatomic, strong) NSString *totalOrBenP;
/** rankLevel	String	排名类型	AREA:大区排名; PROVINCE:省排名; CITY:城市排名 */
@property (nonatomic, strong) NSString *rankLevel;
/** 当currentPage传的值为-1或不传时，查询的是当前用户排名所在的页，第一个就是当前用户所在的名次;
 *  当currentPage正常传值时，查询的是currentPage指定的页数 
 */
@property (nonatomic, strong) NSNumber *currentPage;
/** pageSize	Integer 	每页条数	每页显示的条数：如10 */
@property (nonatomic, strong) NSNumber *pageSize;
@end


