//
//  YHAppInfoOfStoreModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAppInfoOfStoreModel.h"

@implementation YHAppInfoOfStoreModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"results" : [YHAppDetailOfStoreModel class]};
}
@end
