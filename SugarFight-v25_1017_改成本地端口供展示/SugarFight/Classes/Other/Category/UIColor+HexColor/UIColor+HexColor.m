//
//  UIColor+HexColor.m
//  testForXib
//
//  Created by Cui yuhe on 16/3/12.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)yh_colorWithHexColor:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    
    range.length = 2 ;
    
    range.location = 0 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&red];
    
    range.location = 2 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&green];
    
    range.location = 4 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&blue];
    return [ UIColor colorWithRed :( float )(red/ 255.0f ) green :( float )(green/ 255.0f ) blue :( float )(blue/ 255.0f ) alpha : 1.0f ];
    
}

//使用方法：
//
//[nameLabel setTextColor :[UIColor yh_colorWithHexColor : @"5E4333" ]];

@end
