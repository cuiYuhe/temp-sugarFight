//
//  YHCourseQuesAnswerModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCourseQuesAnswerModel : NSObject

/** answerA */
@property (nonatomic, copy) NSString *answerA;
/** answerB */
@property (nonatomic, copy) NSString *answerB;
/** answerC */
@property (nonatomic, copy) NSString *answerC;
/** answerD */
@property (nonatomic, copy) NSString *answerD;
/** questionDescription,题目内容 */
@property (nonatomic, copy) NSString *questionDescription;
/** questionId */
@property (nonatomic, assign) NSInteger questionId;
/** questionScore */
@property (nonatomic, assign) CGFloat questionScore;
/** rightAnswer : A*/
@property (nonatomic, copy) NSString *rightAnswer;

/************************** 添加的属性 *****************************/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 哪个按钮被选中的tag,设置初始值为-1 */
@property (nonatomic, assign) NSInteger pickAnswerTag;
/** 选择答案后的得分,对就得分,不对就为0,算总分数时使用 */
@property (nonatomic, assign) CGFloat pickAnswerScore;

/** 是否做了此题, 重写其get方法 */
@property (nonatomic, assign, getter=isPickedAnswer) BOOL pickedAnswer;
/** 是否做对了此题 */
@property (nonatomic, assign, getter=isAnswerRight) BOOL answerRight;
@end

//左右20
