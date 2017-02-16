//
//  YHHelpDesView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHHelpInfoResult;

@interface YHHelpDesView : UIView
/** YHHelpInfoResult */
@property (nonatomic, strong) YHHelpInfoResult *helpInfoResult;
/** 如果设置了此属性,将在这个点消失 */
//@property (nonatomic, assign) CGPoint hidePoint;


+ (__kindof YHHelpDesView *)helpDesView;

- (void)show;

- (void)dismiss;

//+ (void)dismiss;
@end
