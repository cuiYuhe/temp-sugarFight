//
//  YHPopExerciseScoreView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YHPopExerciseScoreView : UIView

/** score分数 */
@property (nonatomic, assign) NSInteger score;

+ (__kindof YHPopExerciseScoreView *)popExerciseScoreView;

- (void)show;
@end
