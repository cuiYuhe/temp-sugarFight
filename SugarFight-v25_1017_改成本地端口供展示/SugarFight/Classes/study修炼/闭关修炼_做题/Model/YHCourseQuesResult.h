//
//  YHCourseQuesResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHCourseQuesAnswerModel.h"

@interface YHCourseQuesResult : YHBaseModel

/** courseId = 2; */
@property (nonatomic, assign) NSInteger courseId;
/** courseQuestions,数组装着模型:YHCourseQuesAnswerModel */
@property (nonatomic, strong) NSArray<YHCourseQuesAnswerModel *> *courseQuestions;

/** 是否进入练习模式1是，0否 */
@property (nonatomic, assign, getter=isPracticeMode) BOOL practiceMode;

/** 练习模式提示信息 */
@property (nonatomic, copy) NSString *practiceModeMsg;


@end
