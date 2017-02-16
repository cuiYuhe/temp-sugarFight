//
//  YHAccusationBtn.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAccusationBtn.h"


@interface YHAccusationBtn()


@end

@implementation YHAccusationBtn

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
    YHAccusationToolDelegateObj *accusDelegate = [[YHAccusationToolDelegateObj alloc] init];
    self.accusDelegate = accusDelegate;
}

@end








