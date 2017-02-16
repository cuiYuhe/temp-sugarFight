//
//  YHPopExerciseScoreView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopExerciseScoreView.h"
#import "YHPopView.h"

@interface YHPopExerciseScoreView()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/** popView */
@property (nonatomic, strong) YHPopView *popView;

@end

@implementation YHPopExerciseScoreView

- (void)awakeFromNib{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    YHPopView *popView = [YHPopView popView];
    self.popView = popView;
    popView.contentView = self;
    self.scoreLabel.font = YHFontYaHei(24);
}

- (void)setScore:(NSInteger)score{
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"%zd", score];
}

+ (YHPopExerciseScoreView *)popExerciseScoreView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YHPopExerciseScoreView class]) owner:nil options:nil].lastObject;
}

- (void)show{
    [self.popView show];
}

- (IBAction)cfmAction:(UIButton *)sender {
    [self.popView dismiss];
}













@end
