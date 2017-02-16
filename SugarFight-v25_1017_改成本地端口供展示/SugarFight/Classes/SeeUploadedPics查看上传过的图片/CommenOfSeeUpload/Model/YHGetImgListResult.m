//
//  YHGetImgListResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGetImgListResult.h"

@implementation YHGetImgListResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"imgs" : [YHGetImageModel class]};
}

@end
