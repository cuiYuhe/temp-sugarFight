//
//  YHBaseModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"

@implementation YHBaseModel
- (void)setStuatus:(NSNumber *)stuatus{
    _stuatus = stuatus;
    self.status = stuatus;
}

- (void)setMsg:(NSString *)msg{
    _msg = [msg copy];
    _message = [msg copy];
}

@end
