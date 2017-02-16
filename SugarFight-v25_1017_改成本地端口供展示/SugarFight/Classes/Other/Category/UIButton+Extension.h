//
//  UIButton+Extension.h
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)
/** normal 状态下的文字 */
- (void)setNormalTitle:(NSString *)title;
/** highlighted 状态下的文字 */
- (void)setHighlightedTitle:(NSString *)title;
/** selected 状态下的文字 */
- (void)setSelectedTitle:(NSString *)title;
/** normal 状态下的文字颜色 */
- (void)setNormalTitleColor:(UIColor *)color;
/** Disabled 状态下的文字颜色 */
- (void)setDisabledTitleColor:(UIColor *)color;

/** normal状态下的图片 */
- (void)setNormalImage:(NSString *)imageName;
/** highlighted 状态下的背景图片 */
- (void)setHighlightedImage:(NSString *)imageName;
/** selected 状态下的背景图片 */
- (void)setSelectedImage:(NSString *)imageName;

/** normal 状态下的背景图片 */
- (void)setNormalBackgroundImage:(NSString *)imageName;
/** highlighted 状态下的背景图片 */
- (void)setHighlightedbackgroundImage:(NSString *)imageName;
/** selected 状态下的背景图片 */
- (void)setSelectedBackgoundImage:(NSString *)imageName;

/** touchupInside状态下的事件 */
- (void)setTarget:(nullable id)target action:(nonnull SEL)action;
@end

NS_ASSUME_NONNULL_END