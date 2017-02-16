//
//  YHUploadPicGridParam.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHUploadPicGridParam.h"

@implementation YHUploadPicGridParam

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"storeImg1" : [YHSingleImgParam class],
             @"storeImg2" : [YHSingleImgParam class],
             @"storeImg3" : [YHSingleImgParam class]
             };
}
@end
