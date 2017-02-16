//
//  YHStudyInsideExerciseCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHCourseQuesAnswerModel, YHSubmitQuesSubAnswerParam;

@interface YHStudyInsideExerciseCell : UITableViewCell

/** YHCourseQuesAnswerModel */
@property (nonatomic, strong) YHCourseQuesAnswerModel *questionM;

+ (NSString *)identifier;
@end
