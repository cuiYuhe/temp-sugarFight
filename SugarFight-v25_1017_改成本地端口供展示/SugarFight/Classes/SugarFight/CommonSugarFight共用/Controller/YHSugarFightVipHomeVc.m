//
//  YHSugarFightVipHomeVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/23.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightVipHomeVc.h"

@interface YHSugarFightVipHomeVc ()<YHPrideAndSwordTabBarDelegate>

@end

@implementation YHSugarFightVipHomeVc

#pragma mark ------------------------------------------
#pragma mark lazy
- (YHPrideAndSwordVipTabBar *)tabBar{
    if (!_tabBar) {
        YHPrideAndSwordVipTabBar *tabBar = [YHPrideAndSwordVipTabBar prideAndSwordVipTabBar];
        CGFloat tabBarW = YHScreenW;
        CGFloat tabBarH = 60;
        CGFloat tabBarX = 0;
        CGFloat marginToBottom = 5;
        CGFloat tabBarY = YHScreenH - tabBarH - marginToBottom;
        tabBar.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
        [self.view addSubview:tabBar];
        tabBar.delegate = self;
        self.tabBar = tabBar;
    }
    return _tabBar;
}

#pragma mark ------------------------------------------
#pragma mark 子类实现
- (void)loadNewDataAfterShiftingP{}

#pragma mark ------------------------------------------
#pragma mark 子类必须调用super
- (void)setup{
    
    //1.添加tabBar
    [self tabBar];
    
    //2.初始 选择的p 为'本p'
    self.pChosen = [[YHCommonDataTool shareCommonDataTool] getSelectPWithpType:YHPTypeThisP];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------------------------------------------
#pragma mark YHPrideAndSwordTabBarDelegate
- (void)prideAndSwordTabBarDidShiftP:(YHPrideAndSwordVipTabBar *)tabBar thisPOrTotal:(NSString *)pChosen{
    
    //切换下部数据;上部数据为当天,不用切换.
    self.pChosen = pChosen;
    [self loadNewDataAfterShiftingP];
}

@end
