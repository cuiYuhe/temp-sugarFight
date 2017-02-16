//
//  YHCommentResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommentsListResult.h"
#import "YHCommentModel.h"

@implementation YHCommentsListResult


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"pings" : [YHCommentModel class]};
}
@end
