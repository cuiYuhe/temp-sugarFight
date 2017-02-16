//
//  YHLoginModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/26.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHLoginModel.h"
#import "YHLoginDataUserModel.h"

@implementation YHLoginModel
MJExtensionLogAllProperties

- (void)setMessage:(NSString *)message{
    _message = message;
    [GlobeSingle shareGlobeSingle].uuid = message;
}

@end
