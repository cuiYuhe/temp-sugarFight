//
//  UIViewController+Extension.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (void)yh_ModalVcWithSourceVc:(UIViewController *)srVc destinVc:(UIViewController *)destinVc presentAnimated:(BOOL)presentAnim dismissAnimated:(BOOL)dismissAnim presentBlock:(void(^)())presentBlock dismissBlock:(void(^)())dismissBlock{
    
    BOOL isModal = [srVc.presentingViewController isKindOfClass:[destinVc class]];
    if (isModal) {
        !dismissBlock ? : dismissBlock();
        [srVc dismissViewControllerAnimated:dismissAnim completion:nil];
    }else{
        
        !presentBlock ? : presentBlock();
        [srVc presentViewController:destinVc animated:presentAnim completion:nil];
    }
}

///在控制器都是modal出来时(没有nav与tabBar),得到用户能看到的vc
+ (UIViewController *)yh_getTopVc{
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getPresentedVc:rootVc];
}

#pragma mark ------------------------------------------
#pragma mark private method
//递归得到最上面的vc
+ (UIViewController *)getPresentedVc:(UIViewController *)viewController{
    
    if (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
        viewController = [self getPresentedVc:viewController];
    }
    return viewController;
}

@end
