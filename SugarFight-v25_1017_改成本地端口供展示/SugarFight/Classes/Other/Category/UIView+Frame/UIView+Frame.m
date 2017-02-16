//
//  UIView+Frame.m
//
//  Created by 1 on 16/1/4.
//  Copyright © 2014年 cuiyuhe. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (BOOL)yh_intersectWithView:(UIView *)anotherView
{
    if (anotherView == nil) {
        anotherView = [UIApplication sharedApplication].keyWindow;
    }
    
    //由官方文档知,nil时为当前window
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [anotherView convertRect:anotherView.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}

- (void)setYh_centerX:(CGFloat)yh_centerX
{
    CGPoint center = self.center;
    center.x = yh_centerX;
    self.center = center;
}

- (CGFloat)yh_centerX
{
    return self.center.x;
}

- (void)setYh_centerY:(CGFloat)yh_centerY
{
    CGPoint center = self.center;
    center.y = yh_centerY;
    self.center = center;
}

- (CGFloat)yh_centerY
{
    return self.center.y;
}


- (void)setYh_width:(CGFloat)yh_width{
    CGRect frame = self.frame;
    frame.size.width = yh_width;
    self.frame = frame;
}

- (CGFloat)yh_width
{
    return self.frame.size.width;
}

- (void)setYh_height:(CGFloat)yh_height
{
    CGRect frame = self.frame;
    frame.size.height = yh_height;
    self.frame = frame;
}
- (CGFloat)yh_height
{
     return self.frame.size.height;
}

- (void)setYh_x:(CGFloat)yh_x
{
    CGRect frame = self.frame;
    frame.origin.x = yh_x;
    self.frame = frame;
}

- (CGFloat)yh_x
{
    return self.frame.origin.x;
}

- (void)setYh_y:(CGFloat)yh_y
{
    CGRect frame = self.frame;
    frame.origin.y = yh_y;
    self.frame = frame;
}

- (CGFloat)yh_y
{
    return self.frame.origin.y;
}

- (void)setYh_size:(CGSize)yh_size{
    CGRect frame = self.frame;
    frame.size = yh_size;
    self.frame = frame;
}

- (CGSize)yh_size{
    return self.frame.size;
}


+ (UIView *)viewFromXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end
