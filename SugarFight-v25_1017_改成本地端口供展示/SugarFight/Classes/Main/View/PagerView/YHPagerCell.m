//
//  YHPagerCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPagerCell.h"

@interface YHPagerCell()

/** 当点击按钮时,要跳转到的界面 */
@property (nonatomic, weak) UIViewController *homeVc;

@end

@implementation YHPagerCell

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
    self.backgroundColor = YHrgbColorWithAlpha(0, 0, 0, 1);
    
}


- (void)setShowView:(UIView *)showView{
    
    if (_showView) {//cell的循环引用,先删除旧的,再添加新的
        [_showView removeFromSuperview];
    }
    _showView = showView;
    [self.contentView insertSubview:showView atIndex:0];//防止挡住finishBtn
    
    showView.frame = self.bounds;
}

- (void)setFinishBtn:(UIButton *)finishBtn{
    _finishBtn = finishBtn;
    [self.contentView addSubview:finishBtn];
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (void)didClickFinishBtnWithTarget:(id)target action:(SEL)action{
    [self.finishBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ------------------------------------------
#pragma mark external method


#pragma mark ------------------------------------------
#pragma mark pageControl
/**
 - (void)setup{
 
 UIPageControl *pc = [[UIPageControl alloc] init];
 self.pageControl = pc;
 [self.view addSubview:pc];
 pc.numberOfPages = self.images.count;
 CGFloat pcW = 100;
 CGFloat pcH = 30;
 CGFloat pcX = (YHScreenW - pcW) * 0.5;
 CGFloat pcY = 80;
 pc.frame = CGRectMake(pcX, pcY, pcW, pcH);
 pc.currentPageIndicatorTintColor = [UIColor greenColor];
 pc.pageIndicatorTintColor = [UIColor redColor];
 
}
 
#pragma mark ------------------------------------------
#pragma mark ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = page;
}
 */

@end
