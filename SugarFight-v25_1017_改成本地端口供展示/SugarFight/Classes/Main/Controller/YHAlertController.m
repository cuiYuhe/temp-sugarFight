//
//  YHAlertController.m
//  IceManInMay
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAlertController.h"

@interface YHAlertController ()

@end

@implementation YHAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setup];
}


+ (YHAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message singleActionTitle:(NSString *)actionTitle{
    
    YHAlertController *alertVc = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVc addAction:action];
    return alertVc;
}

///两个action
+ (YHAlertController *)alertWithDoubleActionsTitle:(NSString *)title message:(NSString *)message cfmBlock:(void (^)())cfmBlock{
    
    YHAlertController *alertVc = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
        !cfmBlock ? : cfmBlock();
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull at) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    return alertVc;
}

///1个action
+ (YHAlertController *)alertWithSingleActionTitle:(NSString *)title message:(NSString *)message cfmBlock:(void (^)())cfmBlock{
    
    YHAlertController *alertVc = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        !cfmBlock ? : cfmBlock();
    }];
    [alertVc addAction:confirmAction];
    return alertVc;
}

+ (YHAlertController *)alertWithDoubleActionsOfBlueFontTitle:(NSString *)title message:(NSString *)message cfmBlock:(void(^)())cfmBlock{
    YHAlertController *alertVc = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
        !cfmBlock ? : cfmBlock();
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull at) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    return alertVc;
}

@end
