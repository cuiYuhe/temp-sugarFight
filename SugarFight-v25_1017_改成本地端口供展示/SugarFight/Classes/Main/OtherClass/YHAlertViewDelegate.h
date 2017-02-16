//
//  YHAlertViewDelegate.h
//  testAlertView
//
//  Created by Cui yuhe on 16/6/1.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHAlertViewDelegate : NSObject

/**
 *  只有一个按钮'确定',仅仅提示.点击按钮,什么都不做.
 *
 *  @param title       标题
 *  @param message     内容
 *
 *  @return 返回一个对象,这个对象是alertView的代理
 */
- (YHAlertViewDelegate *)alertWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  有两个按钮,点击左边的按钮'取消',什么都不做;点击右边的按钮'确定',执行block方法
 *
 *  @param title       标题
 *  @param message     alertView内容
 *  @param cfmBlock    点击确定时执行的block,注意调用时,使用weakSelf
 *
 *  @return 返回一个对象,这个对象是alertView的代理,
 */
- (YHAlertViewDelegate *)alertWithTitle:(NSString *)title message:(NSString *)message cfmBlock:(void(^)())cfmBlock;

@end
