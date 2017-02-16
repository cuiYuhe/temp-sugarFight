//
//  YHChangePwdM.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHChangePwdParam.h"

@implementation YHChangePwdParam : NSObject

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"modifyPwd" : @"newPwd1",
             @"cfmPwd" : @"newPwd2",
             };
}

@end
