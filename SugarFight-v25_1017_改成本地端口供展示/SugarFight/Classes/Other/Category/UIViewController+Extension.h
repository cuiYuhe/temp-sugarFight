//
//  UIViewController+Extension.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)


/**
*  通过modal的形式跳转至destinVc.封装判断是present还是dismiss
*
*  @param srVc         来源控制器
*  @param destinVc     目标控制器
*  @param presentAnim     present的时候有没有动画
*  @param dismissAnim     dismiss的时候有没有动画
*  @param presentBlock present 前的操作
*  @param dismissBlock dismiss 前的操作
*/
+ (void)yh_ModalVcWithSourceVc:(UIViewController *)srVc destinVc:(UIViewController *)destinVc presentAnimated:(BOOL)presentAnim dismissAnimated:(BOOL)dismissAnim presentBlock:(void(^)())presentBlock dismissBlock:(void(^)())dismissBlock;

///在控制器都是modal出来时(没有nav与tabBar),得到用户能看到的vc
+ (UIViewController *)yh_getTopVc;
@end
