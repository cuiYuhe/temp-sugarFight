//
//  YHSugarFightWSVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightWSVC.h"
#import "YHDailySignInVC.h"

@interface YHSugarFightWSVC ()

@end

@implementation YHSugarFightWSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)settingAction:(id)sender {
}
- (IBAction)addScoreAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHDailySignInVC class]) bundle:nil];
    YHDailySignInVC *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
