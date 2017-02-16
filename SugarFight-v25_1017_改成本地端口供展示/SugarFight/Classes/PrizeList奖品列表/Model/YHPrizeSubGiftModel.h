//
//  YHSubGiftModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPrizeSubGiftModel : NSObject

//    costScore = "2.3";
//    id = 4;
//    imgUrl = "http://icgdb.oss-cn-shanghai.aliyuncs.com/bcr/3a9bc476-36c0-11e6-9ac6-02004c4f4f50_1466411159611.jpg";
//    name = "\U6c34\U676f";
//    probability = "0.6";
//    remain = 1000;
//    version = 0;


/** 抽奖需花费积分 */
@property (nonatomic, copy) NSString *costScore;
/** 礼品图片 */
@property (nonatomic, copy) NSString *imgUrl;
/** 礼品名称 */
@property (nonatomic, copy) NSString *name;
/** 中奖概率 */
@property (nonatomic, copy) NSString *probability;
/** 剩余数量 */
@property (nonatomic, strong) NSNumber *remain;
/** 乐观锁版本号 */
@property (nonatomic, copy) NSString *version;
///gift ID
@property (nonatomic, strong) NSNumber *ID;

@end
