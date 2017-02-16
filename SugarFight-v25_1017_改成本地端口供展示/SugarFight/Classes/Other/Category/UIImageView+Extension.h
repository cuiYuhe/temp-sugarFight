//
//  UIImageView+Extension.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/**
 *  从网络加载图片,及设置占位图片
 *
 *  @param string    网络地址
 *  @param imageName 占位图片的名称
 */
- (void)yh_setImageWithURLString:(NSString *)string imageName:(NSString *)imageName;

@end
