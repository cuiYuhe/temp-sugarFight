//
//  YHProgressBorderView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHProgressBorderView.h"

@implementation YHProgressBorderView


- (void)awakeFromNib{
    [self setup];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setup{
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = MIN(self.yh_height, self.yh_width) * 0.2;
    self.layer.masksToBounds = YES;
}

@end
