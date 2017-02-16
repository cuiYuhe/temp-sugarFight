//
//  YHPopLongNoSeeView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopLongNoSeeView.h"

@interface YHPopLongNoSeeView()


@end

@implementation YHPopLongNoSeeView

+ (YHPopLongNoSeeView *)popLongNoSee{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

#pragma mark events
- (IBAction)longNoSeeCfmAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(popLongNoSeeViewDidClickCfm:)]) {
        [self.delegate popLongNoSeeViewDidClickCfm:self];
    }
    [self removeFromSuperview];
}

@end
