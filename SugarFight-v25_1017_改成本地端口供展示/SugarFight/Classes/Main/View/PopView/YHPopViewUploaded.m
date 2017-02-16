//
//  YHPopViewUploaded.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopViewUploaded.h"


/** mask */
static UIView *_mask;


@implementation YHPopViewUploaded

#pragma mark ------------------------------------------
#pragma mark external methods
+ (YHPopViewUploaded *)popViewUploaded{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

+ (void)showWithFrame:(CGRect)rect{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *mask = [[UIView alloc] initWithFrame:window.bounds];
    _mask = mask;
    mask.backgroundColor = [UIColor blackColor];
    mask.alpha = 0.3;
    [window addSubview:mask];
    YHPopViewUploaded *popV = [self popViewUploaded];
    popV.frame = rect;
    [window addSubview:popV];
    
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)cfmAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.4 animations:^{
        _mask.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [_mask removeFromSuperview];
    }];
}

@end
