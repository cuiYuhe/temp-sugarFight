//
//  YHGetTFPicResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetTFPicResult : NSObject

/** 图片1,上部图片,http://img.icgear.net/per/9e3003d3-2704-11e6-9ac6-02004c4f4f50_1464681225.674315.jpg */
@property (nonatomic, strong) NSString *img1;
/**  图片2,中部图片地址,http:// */
@property (nonatomic, strong) NSString *img2;
/**  图片3, 下部图片地址,http:// */
@property (nonatomic, strong) NSString *img3;
/** 图片1得分 */
@property (nonatomic, strong) NSNumber *img1scores;
/** 图片2得分 */
@property (nonatomic, strong) NSNumber *img2scores;
/** 图片3得分 */
@property (nonatomic, strong) NSNumber *img3scores;
/** 图片id, 论剑的 */
@property (nonatomic, strong) NSNumber *perimgId;
/** 本图片用户id */
@property (nonatomic, strong) NSNumber *userId;
/** 剩余赞的数量 */
@property (nonatomic, strong) NSNumber *zanRemain;

@end
