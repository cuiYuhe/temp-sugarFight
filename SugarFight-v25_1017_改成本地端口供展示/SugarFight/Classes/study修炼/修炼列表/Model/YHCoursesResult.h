//
//  YHCoursesResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHCourseModel.h"

@interface YHCoursesResult : YHBaseModel

/** YHCourseModel array */
@property (nonatomic, strong) NSArray<YHCourseModel *> *courses;
@end
