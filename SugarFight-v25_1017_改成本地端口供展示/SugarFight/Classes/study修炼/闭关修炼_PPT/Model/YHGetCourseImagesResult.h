//
//  YHGetCourseImagesResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"

@interface YHGetCourseImagesResult : YHBaseModel

/** courseId	课程id */
@property (nonatomic, assign) NSInteger courseId;
/** courseImgs	课程图片 */
@property (nonatomic, strong) NSArray *courseImgs;

@end
