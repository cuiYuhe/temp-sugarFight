//
//  YHViewController.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"

@interface YHViewController ()

@end

@implementation YHViewController

#pragma mark ------------------------------------------
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotate{
    return NO;
}

#pragma mark ------------------------------------------
#pragma mark public method.子类继承
- (void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
