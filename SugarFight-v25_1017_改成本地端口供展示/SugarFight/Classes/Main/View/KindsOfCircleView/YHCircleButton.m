//
//  YHCircleButton.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCircleButton.h"

@implementation YHCircleButton

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
    self.layer.cornerRadius = MIN(self.frame.size.width, self.frame.size.height) * 0.5;
    self.layer.masksToBounds = YES;
}
@end
