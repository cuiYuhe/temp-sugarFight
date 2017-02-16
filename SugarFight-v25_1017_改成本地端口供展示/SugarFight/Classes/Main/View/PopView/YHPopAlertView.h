//
//  YHPopAlertView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPopAlertView : UIView

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 内容 */
@property (nonatomic, copy) NSString *content;

+ (__kindof YHPopAlertView *)popAlertViewSingleBtnWithContent:(NSString *)content cfm:(void(^)())cfmBlock;

/**
 *  只设置提示内容,标题默认为'提示'
 *  @return 返回YHPopAlertView对象
 */
+ (__kindof YHPopAlertView *)popAlertViewDoubleBtnWithContent:(NSString *)content cfm:(void(^)())cfmBlock cancel:(void(^)())cancelBlock;

///既设置提示内容,也设置标题
+ (YHPopAlertView *)popAlertViewSingleBtnWithTitle:(NSString *)title content:(NSString *)content cfm:(void (^)())cfmBlock;

/**
 *  创建接收到服务器通知时的alertView,两个btn标题为:'待会再看','去看看'
 */
+ (__kindof YHPopAlertView *)popAlertViewOfNotificationWithContent:(NSString *)content cfm:(void(^)())cfmBlock cancel:(void(^)())cancelBlock;

- (void)show;

- (void)dismiss;
@end
