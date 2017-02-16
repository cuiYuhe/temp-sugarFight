//
//  YHCourseQuesResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCourseQuesResult.h"

@implementation YHCourseQuesResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"courseQuestions" : [YHCourseQuesAnswerModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"practiceMode" : @"isPracticeMode"};
}
@end
