//
//  YHPrideAndSwordTabBar.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPrideAndSwordVipTabBar;

@protocol YHPrideAndSwordTabBarDelegate <NSObject>

@optional
///选择的是本p,还是累计
- (void)prideAndSwordTabBarDidShiftP:(YHPrideAndSwordVipTabBar *)tabBar thisPOrTotal:(NSString *)pChosen;

@end

@interface YHPrideAndSwordVipTabBar : UIView

/** YHPrideAndSwordTabBarDelegate */
@property (nonatomic, weak) id<YHPrideAndSwordTabBarDelegate> delegate;

+ (__kindof YHPrideAndSwordVipTabBar *)prideAndSwordVipTabBar;
@end
