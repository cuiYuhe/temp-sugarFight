//
//  YHGetErrorPicResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetErrorPicResult : NSObject
/**  图片1,中部图片地址,http:// */
@property (nonatomic, strong) NSString *img1;
/**  图片2,中部图片地址,http:// */
@property (nonatomic, strong) NSString *img2;
/** bcr 得分 */
@property (nonatomic, strong) NSNumber *imgscores;
/** bcr图片id */
@property (nonatomic, strong) NSNumber *bcrimgId;
/** 本图片用户id */
@property (nonatomic, strong) NSNumber *userId;
/** 剩余赞的数量 */
@property (nonatomic, strong) NSNumber *zanRemain;


@end
