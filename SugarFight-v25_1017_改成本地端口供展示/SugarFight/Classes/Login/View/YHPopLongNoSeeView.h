//
//  YHPopLongNoSeeView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHPopLongNoSeeView;

@protocol YHPopLongNoSeeViewDelegate <NSObject>

@optional

/**
 *  点击了确定按钮.设置代理,而不是在当前view操作,是为了统一管理跳转控制器
 *
 *  @param popView
 */
- (void)popLongNoSeeViewDidClickCfm:(YHPopLongNoSeeView *)popView;

@end

@interface YHPopLongNoSeeView : UIView

/** delegate */
@property (nonatomic, weak) id<YHPopLongNoSeeViewDelegate> delegate;

+ (__kindof YHPopLongNoSeeView *)popLongNoSee;

@end
