//
//  YHAlertController.h
//  IceManInMay
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHAlertController : UIAlertController

/**
 *  返回弹出警示框, 只有一个action
 *
 *  @param title       警示框标题
 *  @param message     警示框内容
 *  @param actionTitle action的标题
 *
 *  @return alertVc
 */
+ (YHAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message singleActionTitle:(NSString *)actionTitle;

/**
 *  返回弹出警示框, 有两个action:确定与取消.'确定'的字体是'红色',适用于注销.
 *
 *  @param title       警示框标题
 *  @param message     警示框内容
 *  @param cfmBlock    选择'确定'时的回调
 *
 *  @return alertVc
 */
+ (YHAlertController *)alertWithDoubleActionsTitle:(NSString *)title message:(NSString *)message cfmBlock:(void(^)())cfmBlock;

/**
 *  返回弹出警示框, 有两个action:确定与取消.都是蓝色.
 *
 *  @param title       警示框标题
 *  @param message     警示框内容
 *  @param cfmBlock    选择'确定'时的回调
 *
 *  @return alertVc
 */
+ (YHAlertController *)alertWithDoubleActionsOfBlueFontTitle:(NSString *)title message:(NSString *)message cfmBlock:(void(^)())cfmBlock;

/**
 *  返回弹出警示框, 有1个action:确定红色.
 *
 *  @param title       警示框标题
 *  @param message     警示框内容
 *  @param cfmBlock    选择'确定'时的回调
 *
 *  @return alertVc
 */
+ (YHAlertController *)alertWithSingleActionTitle:(NSString *)title message:(NSString *)message cfmBlock:(void (^)())cfmBlock;



@end
