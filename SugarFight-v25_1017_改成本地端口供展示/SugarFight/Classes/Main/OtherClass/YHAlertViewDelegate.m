//
//  YHAlertViewDelegate.m
//  testAlertView
//
//  Created by Cui yuhe on 16/6/1.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAlertViewDelegate.h"

@interface YHAlertViewDelegate()<UIAlertViewDelegate>


@property (nonatomic, copy) void(^block)();
@end

@implementation YHAlertViewDelegate

- (YHAlertViewDelegate *)alertWithTitle:(NSString *)title message:(NSString *)message{
    
    YHAlertViewDelegate *avDelegate = [[YHAlertViewDelegate alloc] init];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    av.delegate = self;
    [av show];
    return avDelegate;
}

- (YHAlertViewDelegate *)alertWithTitle:(NSString *)title message:(NSString *)message cfmBlock:(void (^)())cfmBlock{
    YHAlertViewDelegate *avDelegate = [[YHAlertViewDelegate alloc] init];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    av.delegate = self;
    self.block = cfmBlock;
    [av show];
    return avDelegate;
}

#pragma mark ------------------------------------------
#pragma mark UIAlertViewDelegate, 点击取消按钮时的操作,当只有一个按钮时,就是取消按钮
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    if (buttonIndex == 1){ //0取消,1确定
        !self.block ? : self.block();
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"test");
}


@end
