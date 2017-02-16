//
//  YHScoreDetailModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHScoreDetailModel : NSObject
/** pTotalScore P总分 */
@property (nonatomic, strong) NSNumber *pTotalScore;
/** P笑傲江湖总分 */
@property (nonatomic, strong) NSNumber *pBrcScore;
/** P华山论剑总分 */
@property (nonatomic, strong) NSNumber *pPreScore;
/** P签到总分 */
@property (nonatomic, strong) NSNumber *pSignScore;
/** P全国排名 */
@property (nonatomic, strong) NSNumber *pNationRanking;
/** p大区排名 */
@property (nonatomic, strong) NSNumber *pAreaRanking;
/** P省排名 */
@property (nonatomic, strong) NSNumber *pProvinceRanking;
/** P城市排名 */
@property (nonatomic, strong) NSNumber *pCityRanking;
/** P笑傲江湖闯关完成度 */
@property (nonatomic, strong) NSNumber *pBcrRate;
/** P华山论剑闯关完成度 */
@property (nonatomic, strong) NSNumber *pPreRate;
/** P总分闯关完成度 */
@property (nonatomic, strong) NSNumber *pTotalRate;
/**  pStadyScore 修炼得分 */
@property (nonatomic, strong) NSNumber *pStadyScore;
/** P笑傲江湖总分变化　1：增加，0不变，－1减少 */
@property (nonatomic, strong) NSNumber *pBrcScoreChange;
/** pPreScoreChange, P华山论剑总分变化　1：增加，0不变，－1减少 */
@property (nonatomic, strong) NSNumber *pPreScoreChange;
/** pStadyScoreChange;	//P修炼得分变化　1：增加，0不变，－1减少 */
@property (nonatomic, strong) NSNumber *pStadyScoreChange;

/** 总分 */
@property (nonatomic, strong) NSNumber *totalScore;
/** 笑傲江湖总分 */
@property (nonatomic, strong) NSNumber *brcScore;
/** 华山论剑总分 */
@property (nonatomic, strong) NSNumber *preScore;
/** 签到总分 */
@property (nonatomic, strong) NSNumber *signScore;
/** 全国排名 */
@property (nonatomic, strong) NSNumber *nationRanking;
/** 大区排名 */
@property (nonatomic, strong) NSNumber *areaRanking;
/** 省排名 */
@property (nonatomic, strong) NSNumber *provinceRanking;
/** 城市排名 */
@property (nonatomic, strong) NSNumber *cityRanking;
/** 笑傲江湖闯关完成度 */
@property (nonatomic, strong) NSNumber *bcrRate;
/** 华山论剑闯关完成度 */
@property (nonatomic, strong) NSNumber *preRate;
/** 总分闯关完成度 */
@property (nonatomic, strong) NSNumber *totalRate;
/**  stadyScore 修炼得分 */
@property (nonatomic, strong) NSNumber *stadyScore;
/** 	brcScoreChange;笑傲江湖总分变化　1：增加，0不变，－1减少 */
@property (nonatomic, strong) NSNumber *brcScoreChange;
/** preScoreChange;	华山论剑总分变化　1：增加，0不变，－1减少 */
@property (nonatomic, strong) NSNumber *preScoreChange;
/** stadyScoreChange;	//P修炼得分变化　1：增加，0不变，－1减少 */
@property (nonatomic, strong) NSNumber *stadyScoreChange;



@end
