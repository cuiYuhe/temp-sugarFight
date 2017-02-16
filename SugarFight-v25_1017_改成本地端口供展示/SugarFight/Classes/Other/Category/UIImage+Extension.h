//
//  UIImage+Extension.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  拿到UIImage的md5Hash值,去重.
 */
- (NSString *)yh_md5HashFromUIImage;

/**
 *  返回一张可以随意拉伸不变形的图片
 *  @param name 图片名字
 */
+ (UIImage *)yh_resizableImage:(NSString *)name;

///压缩图片,最大300K
//- (UIImage *)yh_compressImage;

///压缩图片,返回data
- (NSData *)yh_compressImageReturnData;

@end
