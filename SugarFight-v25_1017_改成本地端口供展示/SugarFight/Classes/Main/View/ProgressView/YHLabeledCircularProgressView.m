//
//  YHProgressView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHLabeledCircularProgressView.h"

@implementation YHLabeledCircularProgressView

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
    self.roundedCorners = 5.0f;
    self.progressLabel.textColor = [UIColor whiteColor];
    self.thicknessRatio = 0.3;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
