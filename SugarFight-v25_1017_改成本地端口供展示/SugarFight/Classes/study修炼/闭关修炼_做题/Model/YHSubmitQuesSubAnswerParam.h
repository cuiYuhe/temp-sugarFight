//
//  YHSubmitQuesSubAnswerParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSubmitQuesSubAnswerParam : NSObject

/** questionId */
@property (nonatomic, assign) NSInteger questionId;
/** choiceAnswer */
@property (nonatomic, copy) NSString *choiceAnswer;
/** answerScore */
@property (nonatomic, assign) CGFloat answerScore;
@end
