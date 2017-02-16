//
//  YHPopNoZanView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopNoZanView.h"

@interface YHPopNoZanView()
/** 全屏的 mask */
@property (nonatomic, weak) UIView *mask;

@end

@implementation YHPopNoZanView
- (UIView *)mask{
    if (!_mask) {
        UIView *view = [[UIView alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:view];
        view.frame = window.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.2;
        self.mask = view;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_mask addGestureRecognizer:tap];
    }
    return _mask;
}

- (void)dismiss{
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
    self.mask = nil;
}

#pragma mark ------------------------------------------
#pragma mark external method

+ (YHPopNoZanView *)popNoZanView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)show{
    
    [self mask];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.center = self.mask.center;
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)cfmAction:(UIButton *)sender {
    [self dismiss];
}

- (void)tap:(UITapGestureRecognizer *)tapGes{
    [self dismiss];
}

@end
