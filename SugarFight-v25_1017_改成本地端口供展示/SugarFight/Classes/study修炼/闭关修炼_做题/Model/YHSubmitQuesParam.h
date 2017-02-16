//
//  YHSubmitQuesParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHSubmitQuesSubAnswerParam.h"

@interface YHSubmitQuesParam : NSObject
/** uid */
@property (nonatomic, strong) NSNumber *uid;
/** uuid */
@property (nonatomic, strong) NSString *uuid;
/** courseId */
@property (nonatomic, assign) NSInteger courseId;
/** totalScore */
@property (nonatomic, assign) CGFloat totalScore;
/** answers */
@property (nonatomic, strong) NSArray<YHSubmitQuesSubAnswerParam *> *answers;
@end
