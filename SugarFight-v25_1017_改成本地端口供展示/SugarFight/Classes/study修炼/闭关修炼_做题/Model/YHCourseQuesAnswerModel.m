//
//  YHCourseQuesAnswerModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCourseQuesAnswerModel.h"

/**

 0.题目序号上margin = 5,
 1.问题: 题目序号w = 20, 间距: 10;
 2.选项: 上面的30 + 选择按钮宽20 + 间距5
 
 */
static CGFloat const YHTopMargin = 5;
/** 大多数的margin,都是10 */
static CGFloat const YHCommonMargin = 10;
/** 所有label的字体,都是14 */
static CGFloat const YHCommonLabelFont = 14;
/** 序号按钮宽度:20 */
static CGFloat const YHExerciseIndexWidth = 20;
/** 问题描述label与序号按钮的间距: */
static CGFloat const YHMarginOfQuesLabelToExerIndexBtn = 10;
/** 选择按钮宽度 */
static CGFloat const YHSelectAnswerBtnWidth = 20;
/** 选择按钮与答案之前的间距 */
static CGFloat const YHMarginBetweenSelectBtnAndAnswer = 5;
/** 分隔线高度 */
static CGFloat const YHSeperatorLineHeight = 3;

@interface YHCourseQuesAnswerModel()
/** 计算label高度时的attrs */
@property (nonatomic, strong) NSDictionary *attrs;

@end

@implementation YHCourseQuesAnswerModel
- (NSDictionary *)attrs{
    if (!_attrs) {
        self.attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:YHCommonLabelFont]};
    }
    return _attrs;
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        
        //距离顶部的间距:上间距
        _cellHeight += YHTopMargin;
        
        //问题label的宽度 = cellW - 序号按钮宽度 - 两者之间margin
        CGFloat QueslabelWidth = [GlobeSingle shareGlobeSingle].tableViewWidthOfExercise - YHExerciseIndexWidth - YHMarginOfQuesLabelToExerIndexBtn;
        
        
        YHLog(@"----- screenW = %f, w = %f", YHScreenW - 40, [GlobeSingle shareGlobeSingle].tableViewWidthOfExercise);
        //问题高度
        CGFloat quesHeight = [_questionDescription boundingRectWithSize:CGSizeMake(QueslabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.attrs context:nil].size.height;
        _cellHeight += quesHeight + YHCommonMargin;
        if (_questionId == 5 || _questionId == 4) {
            YHLog(@"ID = %zd, quesHeight = %f, queDesc = %@", _questionId, quesHeight, _questionDescription);
        }
        
        if (self.questionId == 3 || self.questionId == 2) {
            YHLog(@"anweA = %@, _cellHeightQQQques = %f, quesHeight = %f", self.answerA, _cellHeight, quesHeight);
            YHLog(@"_questionDescription = %@", _questionDescription);
        }
        
        //选项A,B,C,D
        //答案label的宽度 = cellW - 序号按钮宽度 - 两者之间margin - 选择按钮的宽度 - 答案与此按钮margin
        CGFloat answerAHeight = [self answerOptionHeight:_answerA];
        _cellHeight += answerAHeight;
        
        
        CGFloat answerBHeight = [self answerOptionHeight:_answerB];
        _cellHeight += answerBHeight;
        
        CGFloat answerCHeight = [self answerOptionHeight:_answerC];
        _cellHeight += answerCHeight;
        
        CGFloat answerDHeight = [self answerOptionHeight:_answerD];
        _cellHeight += answerDHeight;
        
        //分隔线高度
        _cellHeight += YHSeperatorLineHeight;
        
    }
    
    return _cellHeight;
}

- (instancetype)init{
    if (self = [super init]) {
        self.pickAnswerTag = -1;
    }
    return self;
}

- (BOOL)isPickedAnswer{
    return self.pickAnswerTag > 0;
}

#pragma mark ------------------------------------------
#pragma mark private method
//答案选项的宽度
- (CGFloat)answerLabelWidth{
    return [GlobeSingle shareGlobeSingle].tableViewWidthOfExercise - YHExerciseIndexWidth - YHMarginOfQuesLabelToExerIndexBtn  - YHSelectAnswerBtnWidth - YHMarginBetweenSelectBtnAndAnswer;
}
//计算某个答案选项的高度,如answerA
- (CGFloat)answerOptionHeight:(NSString *)answerOption{
    if (!answerOption || [answerOption isEqualToString:@""]) {//没有这个选项
        return 0;
    }else{
        CGFloat answerHeight = [answerOption boundingRectWithSize:CGSizeMake(self.answerLabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.attrs context:nil].size.height;
//        if (self.questionId == 3 || self.questionId == 2) {
//            YHLog(@"anweA = %@, answerHeight = %f", self.answerA, answerHeight);
//        }
        return answerHeight + YHCommonMargin;
    }
}
@end
