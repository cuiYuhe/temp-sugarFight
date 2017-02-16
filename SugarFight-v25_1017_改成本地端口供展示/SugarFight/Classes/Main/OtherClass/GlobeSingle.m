//
//  GlobeSingle.m
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "GlobeSingle.h"
#import "YHLoginModel.h"
#import "YHSugarFightDistrictVC.h"
#import "YHSugarFightHeadVC.h"
#import "YHSugarFightProvinceAndCityVC.h"
#import "YHSugarFightWSVC.h"
#import "YHSugarFightNotWSVC.h"

@interface GlobeSingle()


@end

@implementation GlobeSingle
SingleM(GlobeSingle)

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setLoginM:(YHLoginModel *)loginM{
    //test
    /** vipLevel,0:普通用户;1:全国 2.大区 3.省 4:城市 */
//    loginM.vipLevel = 2;
    
    _loginM = loginM;
    NSInteger userLevel = loginM.vipLevel;
    BOOL isVip = userLevel != 0;
    if (isVip) {//vip用户
        switch (userLevel) {
            case 1:
                self.userType = YHUserTypeVipNation;
                break;
            case 2:
                self.userType = YHUserTypeVipDistrict;
                break;
            case 3:
                self.userType = YHUserTypeVipProvince;
                break;
            case 4:
                self.userType = YHUserTypeVipCity;
                break;
                
            default:
                break;
        }
    }else{//非vip用户
        if ([self.loginM.userWay isEqualToString:@"WS"]) { //WS用户
            self.userType = YHUserTypeCommonWS;
        }else{
            self.userType = YHUserTypeCommonNotWS;
        }
    }
}

///根据用户类型,跳转的目的vc.
- (UIViewController *)findWhatUserType{
    /** vipLevel,0:普通用户;1:全国 2.大区 3.省 4:城市 */
    switch (self.userType) {
        case YHUserTypeCommonWS:
            return [self vcWithSbName:NSStringFromClass([YHSugarFightWSVC class])];
            break;
        case YHUserTypeCommonNotWS:
            return [self vcWithSbName:NSStringFromClass([YHSugarFightNotWSVC class])];
            break;
        case YHUserTypeVipNation:
            return [self vcWithSbName:NSStringFromClass([YHSugarFightHeadVC class])];
            break;
        case YHUserTypeVipDistrict:
            return [self vcWithSbName:NSStringFromClass([YHSugarFightDistrictVC class])];
            break;
        case YHUserTypeVipProvince:
        case YHUserTypeVipCity:
            return [self vcWithSbName:NSStringFromClass([YHSugarFightProvinceAndCityVC class])];
            break;
            
        default:
            break;
    }
}

- (UIViewController *)vcWithSbName:(NSString *)sbName{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    YHViewController *vc = [sb instantiateInitialViewController];
    return vc;
}

///在控制器都是modal出来时(没有nav与tabBar),得到用户能看到的vc
- (UIViewController *)getTopVc{
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getPresentedVc:rootVc];
}

//递归得到最上面的vc
- (UIViewController *)getPresentedVc:(UIViewController *)viewController{
    
    if (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
        viewController = [self getPresentedVc:viewController];
    }
    return viewController;
}

@end
