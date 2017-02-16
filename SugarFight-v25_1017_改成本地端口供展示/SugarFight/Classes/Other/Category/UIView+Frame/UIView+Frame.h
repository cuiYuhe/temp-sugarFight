//
//  UIView+Frame.h
//
//  Created by 1 on 16/1/4.
//  Copyright © 2014年 cuiyuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

// @property只会生成get,set方法声明,不会生成实现和下划线成员属性
// 开发规范:自己的分类,尽量添加项目前缀
@interface UIView (Frame)

@property CGFloat yh_width;
@property CGFloat yh_height;
@property CGFloat yh_x;
@property CGFloat yh_y;
@property CGFloat yh_centerX;
@property CGFloat yh_centerY;
@property CGSize yh_size;


/**
 *  判断屏幕上的self是否和anotherView有重叠
 */
- (BOOL)yh_intersectWithView:(UIView *)anotherView;

+ (__kindof UIView *)viewFromXib;
@end
