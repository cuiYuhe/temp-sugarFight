//
//  UIImage+Extension.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "UIImage+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIImage (Extension)

- (NSString *)yh_md5HashFromUIImage{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self)];
    
    //不加这个强转(unsigned int)有警告
    CC_MD5([imageData bytes], (unsigned int)[imageData length], result);
    NSString *imageHash = [NSString stringWithFormat:
                           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return imageHash;

}

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)yh_resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

///压缩图片
- (UIImage *)yh_compressImage{
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    //要求200K左右,设置最大值300K
    NSUInteger maxFileSize = 300 * 1000;
    CGFloat minValue = 200.0f;
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    CGFloat valueW = 500;
    
    UIImage *newImage = self;
    while ([imageData length] > maxFileSize && valueW > minValue){
        YHLog(@"imageData.length = %zd", [imageData length]);
        valueW -= 50;
        CGFloat valueH = valueW * height / width;
        UIGraphicsBeginImageContext(CGSizeMake(valueW, valueH));
        //    [image drawInRect:CGRectMake(0, 0, w, h)];
        [self drawInRect:CGRectMake(0, 0, valueW, valueH)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageData = UIImageJPEGRepresentation(newImage, 1.0);
        YHLog(@"imageData.length = %zd", [imageData length]);
    }
    
    return newImage;
    
    /*
     //下面这个方法,1.3M的图片NSData确实变小,但是转化成图片上传的后,发现图片没变小;而8M的图片会变成1M多.
     
    //要求200K左右,设置最大值300K
    NSUInteger maxFileSize = 300 * 1000;
    CGFloat compression = 0.7f;
    CGFloat maxCompression = 0.01f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);

    YHLog(@"before : len = %lu", [imageData length]);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.01;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    
    YHLog(@"after : len = %lu", [imageData length]);
//    UIImage *compressedImage = [UIImage imageWithData:imageData];
    UIImage *compressedImage = [[UIImage alloc]initWithData:imageData];
    return compressedImage;
     */
}

///压缩图片,返回data
- (NSData *)yh_compressImageReturnData{
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    //要求200K左右,设置最大值300K
    NSUInteger maxFileSize = 300 * 1000;
    CGFloat minValue = 200.0f;
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    CGFloat valueW = 500;
    
    UIImage *newImage = nil;
    while ([imageData length] > maxFileSize && valueW > minValue){
        YHLog(@"imageData.length = %zd", [imageData length]);
        valueW -= 50;
        CGFloat valueH = valueW * height / width;
        UIGraphicsBeginImageContext(CGSizeMake(valueW, valueH));
        //    [image drawInRect:CGRectMake(0, 0, w, h)];
        [self drawInRect:CGRectMake(0, 0, valueW, valueH)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageData = UIImageJPEGRepresentation(newImage, 1.0);
    }
    YHLog(@"imageData.length = %zd", [imageData length]);
    
    return imageData;
}
@end
