//
//  YHSwordSongImgSubModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSwordSongImgSubModel : NSObject

/** 战役图片id */
@property (nonatomic, strong) NSNumber *imgId;
/** 门店1图片1 */
@property (nonatomic, strong) NSString *store1Img1;
@property (nonatomic, strong) NSString *store1Img2;
@property (nonatomic, strong) NSString *store2Img1;
@property (nonatomic, strong) NSString *store2Img2;
@property (nonatomic, strong) NSString *store3Img1;
@property (nonatomic, strong) NSString *store3Img2;
/** 本图片用户id */
@property (nonatomic, strong) NSNumber *userId;
/** 剩余赞数 */
@property (nonatomic, strong) NSNumber *zanRemain;


@end
