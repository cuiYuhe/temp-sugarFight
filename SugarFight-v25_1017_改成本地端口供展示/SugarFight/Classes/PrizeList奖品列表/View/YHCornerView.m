//
//  YHCornerView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCornerView.h"

@implementation YHCornerView

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
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
