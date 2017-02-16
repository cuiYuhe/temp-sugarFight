//
//  UIImageView+Extension.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Extension)

- (void)yh_setImageWithURLString:(NSString *)string imageName:(NSString *)imageName{
    
    NSURL *url = [NSURL URLWithString:string];
    UIImage *img = [UIImage imageNamed:imageName];
    [self sd_setImageWithURL:url placeholderImage:img];
    
    
}

@end
