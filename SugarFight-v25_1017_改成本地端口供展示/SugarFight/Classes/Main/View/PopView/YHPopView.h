//
//  YHPopView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPopView : UIView
/** 展示的内容view */
@property (nonatomic, weak) UIView *contentView;
/** 点击时,不启动手势:消失 */
@property (nonatomic, assign, getter=isClickNoResponse) BOOL clickNoResponse;
/** 如果设置了此属性,将在这个点消失 */
//@property (nonatomic, assign) CGPoint hidePoint;

+ (__kindof YHPopView *)popView;

//+ (void)show;
- (void)show;

//+ (void)dismiss;
- (void)dismiss;
@end
