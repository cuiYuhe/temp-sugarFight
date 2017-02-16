//
//  YHGetImgListResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHGetImageModel.h"

@interface YHGetImgListResult : NSObject

/** imgs,图片数组 */
@property (nonatomic, strong) NSArray<YHGetImageModel *> *imgs;
/** message */
@property (nonatomic, strong) NSString *message;
/** score */
@property (nonatomic, strong) NSNumber *score;
/** 第1组,第1张图片 */
@property (nonatomic, strong) YHGetImageModel *store1Img1;
/** 第1组,第2张图片 */
@property (nonatomic, strong) YHGetImageModel *store1Img2;
/** 第2组,第1张图片 */
@property (nonatomic, strong) YHGetImageModel *store2Img1;
/** 第2组,第2张图片 */
@property (nonatomic, strong) YHGetImageModel *store2Img2;
/** 第3组,第1张图片 */
@property (nonatomic, strong) YHGetImageModel *store3Img1;
/** 第3组,第2张图片 */
@property (nonatomic, strong) YHGetImageModel *store3Img2;

/** success */
@property (nonatomic, strong) NSNumber *success;
/** totalZan,总赞数量 */
@property (nonatomic, strong) NSNumber *totalZan;
/** vip的赞数量 */
@property (nonatomic, strong) NSNumber *vipZan;
@end
