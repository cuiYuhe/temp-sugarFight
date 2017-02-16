//
//  YHPopChangePwdView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopChangePwdView.h"
#import "YHChangePwdVC.h"

@implementation YHPopChangePwdView

+ (YHPopChangePwdView *)popChangePwdView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)changePwdCfmAction:(UIButton *)sender {
    YHFunc
    //1.跳转到修改密码界面
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHChangePwdVC class]) bundle:nil];
    YHChangePwdVC *changePwdVc = [sb instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = changePwdVc;
}

@end
