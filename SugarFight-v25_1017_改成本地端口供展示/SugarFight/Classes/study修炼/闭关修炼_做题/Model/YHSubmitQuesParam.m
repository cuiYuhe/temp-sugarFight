//
//  YHSubmitQuesParam.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSubmitQuesParam.h"

@implementation YHSubmitQuesParam

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"answers" : [YHSubmitQuesSubAnswerParam class]};
}
@end
