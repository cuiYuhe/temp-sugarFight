//
//  YHPopChangeScoreView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPopChangeScoreView;

@protocol YHPopChangeScoreViewDelegate <NSObject>

@optional

/**
 *  点击了确定按钮.设置代理,而不是在当前view操作,是为了统一管理跳转控制器
 *
 *  @param popView
 */
- (void)popChangeScoreViewDidClickCfm:(YHPopChangeScoreView *)popView;

@end

@interface YHPopChangeScoreView : UIView


/** delegate */
@property (nonatomic, weak) id<YHPopChangeScoreViewDelegate> delegate;

+ (__kindof YHPopChangeScoreView *)popChangeScoreView;


@end
