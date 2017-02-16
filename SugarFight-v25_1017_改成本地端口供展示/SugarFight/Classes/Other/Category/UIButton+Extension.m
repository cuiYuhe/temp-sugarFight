//
//  UIButton+Extension.m
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

#pragma mark ------------------------------------------
#pragma mark 文字
- (void)setNormalTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setHighlightedTitle:(NSString *)title{

    [self setTitle:title forState:UIControlStateHighlighted];

}

- (void)setSelectedTitle:(NSString *)title{

    [self setTitle:title forState:UIControlStateSelected];
}

- (void)setNormalTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setDisabledTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateDisabled];
}

#pragma mark ------------------------------------------
#pragma mark image
- (void)setNormalImage:(NSString *)imageName{

    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setHighlightedImage:(NSString *)imageName{

    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)setSelectedImage:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

#pragma mark ------------------------------------------
#pragma mark background image
- (void)setNormalBackgroundImage:(NSString *)imageName{
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

}

- (void)setHighlightedbackgroundImage:(NSString *)imageName{
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)setSelectedBackgoundImage:(NSString *)imageName{
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

#pragma mark ------------------------------------------
#pragma mark event
- (void)setTarget:(nullable id)target action:(nonnull SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end

