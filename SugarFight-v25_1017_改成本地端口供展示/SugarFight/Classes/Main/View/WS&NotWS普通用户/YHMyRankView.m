//
//  YHMyRankView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHMyRankView.h"
#import "YHMyRankParam.h"
#import "YHMyRankingVC.h"

@implementation YHMyRankView
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

#pragma mark ------------------------------------------
#pragma mark 手势
- (void)tap:(UITapGestureRecognizer *)tapGes{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHMyRankingVC class]) bundle:nil];
    YHMyRankingVC *vc = [sb instantiateInitialViewController];
    
//    UIViewController *topVc = [UIViewController yh_getTopVc];
//    [UIViewController yh_ModalVcWithSourceVc:topVc destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
//    UIViewController *vc2 = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

@end
