//
//  YHNewFeatureVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/15.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHNewFeatureVC.h"
#import "YHPagerView.h"

static CGFloat YHMarginOfEnterBtnToBottom = 20;

@interface YHNewFeatureVC ()<YHPagerViewDelegate>

@end

@implementation YHNewFeatureVC

- (void)loadView{
    
    //设置rect的原因是.YHPagerView的初始化中需要大小
    CGRect rect = [UIScreen mainScreen].bounds;
    YHPagerView *pv = [[YHPagerView alloc] initWithFrame:rect];
    self.view = pv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    
    //YHPagerView展示的views
    NSMutableArray *imageViews = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_0%zd", i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageViews addObject:imageView];
    }
    YHPagerView *pv = (YHPagerView *)self.view;
    pv.showViews = imageViews;
    pv.delegate = self;
}

#pragma mark ------------------------------------------
#pragma mark YHPagerViewDelegate
//最后界面的按钮
- (UIButton *)pagerViewShouldHaveFinishBtnAtLastIndexPath:(YHPagerView *)pagerView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setNormalBackgroundImage:@"enterBtn"];

    CGFloat btnW = 200.0f;
    CGFloat btnH = btnW * 79/315;
    CGFloat btnX = (YHScreenW - btnW) * 0.5;
    CGFloat btnY = YHScreenH - btnH - YHScreenH * 101/1280 - YHMarginOfEnterBtnToBottom;

    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    return btn;
}

//点击了最后界面的按钮事件
- (void)pagerViewDidClickFinishBtn:(YHPagerView *)pagerView{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YHViewController *vc2 = [sb instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc2;
}

@end
