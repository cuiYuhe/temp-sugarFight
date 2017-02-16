//
//  YHUploadPicGridParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHSingleImgParam.h"

@interface YHUploadPicGridParam : NSObject

@property (nonatomic, strong) NSNumber *uid;
/** YHSingleImgParam数组 */
@property (nonatomic, strong) NSArray<YHSingleImgParam *> *storeImg1;
@property (nonatomic, strong) NSArray<YHSingleImgParam *> *storeImg2;
@property (nonatomic, strong) NSArray<YHSingleImgParam *> *storeImg3;
/** uuid */
@property (nonatomic, strong) NSString *uuid;
@end
