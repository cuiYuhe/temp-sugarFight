//
//  YHPopField.h
//  testPopFIeld
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
// 监听键盘弹出

#import <UIKit/UIKit.h>

@interface YHPopField : UITextField

/** 需要移动的控件.有时候应该为当前field的父控件 */
@property (nonatomic, weak) UIView *targetOffsetView;
/** 偏移时,与键盘的间距.如果不设置,默认为15. */
@property (nonatomic, assign) CGFloat marginToKeyboard;

///初始化设置,子类调用时,要调用[super setup];
- (void)setup;

@end
