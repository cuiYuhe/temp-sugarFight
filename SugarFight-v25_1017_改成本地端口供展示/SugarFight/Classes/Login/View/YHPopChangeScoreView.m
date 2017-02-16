//
//  YHPopChangeScoreView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopChangeScoreView.h"
#import "YHSugarFightWSVC.h"
#import "YHSugarFightNotWSVC.h"
#import "YHSugarFightHeadVC.h"
#import "YHSugarFightDistrictVC.h"
#import "YHSugarFightProvinceAndCityVC.h"
#import "YHLoginModel.h"

@interface YHPopChangeScoreView()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation YHPopChangeScoreView

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
    self.scoreLabel.font = YHFontYaHei(24);
}

+ (YHPopChangeScoreView *)popChangeScoreView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    YHLoginModel *loginM = [GlobeSingle shareGlobeSingle].loginM;
    CGFloat score = loginM.scoreChange.doubleValue;
    
    NSString *scoreChange = nil;
    if (score < 0) {
        scoreChange = [NSString stringWithFormat:@"%.1f", score];
    }else{
        scoreChange = [NSString stringWithFormat:@"+ %.1f", score];
    }
    
    self.scoreLabel.text = scoreChange;
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)changeScoreCfmAction:(UIButton *)sender {
    YHFunc
    if ([self.delegate respondsToSelector:@selector(popChangeScoreViewDidClickCfm:)]) {
        [self.delegate popChangeScoreViewDidClickCfm:self];
    }
    
}

#pragma mark ------------------------------------------
#pragma mark external methods


@end
