//
//  YHUpdateVersionVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/28.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHUpdateVersionVc.h"
#import "YHAlertController.h"

#import "YHPopView.h"
#import "YHPopAlertView.h"
#import "YHAppInfoOfStoreModel.h"
#import "YHUpdateVersionVc.h"


@interface YHUpdateVersionVc ()

@end

@implementation YHUpdateVersionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    UIImage *img = [UIImage imageNamed:@"bg"];
    imgV.image = img;
    imgV.frame = self.view.bounds;
    [self.view addSubview:imgV];
    
    //加载并检查是否是最新版本
    [self loadAndCheckIfLatestVersion];
}

#pragma mark ------------------------------------------
#pragma mark private method
- (BOOL)checkIfLatestVersion:(NSString *)currentVersion response:(id)responseObj{
    YHAppInfoOfStoreModel *appInfo = [YHAppInfoOfStoreModel mj_objectWithKeyValues:responseObj];
    YHAppDetailOfStoreModel *detailM = appInfo.results.firstObject;
    NSString *version = detailM.version;
    YHLog(@"当前版本为：%@", version);
    return [version isEqualToString:currentVersion];
}

///加载并检查是否是最新版本
- (void)loadAndCheckIfLatestVersion{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    [self getUpdateInfoFromAppStore:^(id responseObj) {
        BOOL isLatestVersion = [self checkIfLatestVersion:currentVersion response:responseObj];
        //检查是否为最新版本
#if DEBUG
        //test
          isLatestVersion = 1;
#endif
        if (!isLatestVersion) {
            //提示更新版本
            YHPopAlertView *pav = [YHPopAlertView popAlertViewSingleBtnWithContent:@"sorry亲!请更新至最新版本,否则不能使用本app!" cfm:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:YHAppAddressInAppStore]];
            }];
            [pav show];
        }else{
            YHViewController *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:@"Main"];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        }
        
    } failed:^(NSError *error) {
        
        WeakSelf
        YHPopAlertView *pav = [YHPopAlertView popAlertViewSingleBtnWithContent:@"网络有问题" cfm:^{
            StrongSelf
            [strongSelf loadAndCheckIfLatestVersion];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [pav show];
        });
    }];
    
}

//从appStore得到更新信息
- (void)getUpdateInfoFromAppStore:(void(^)(id responseObj))success failed:(void(^)(NSError *error))failed{
    //不要用自己的更新
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", YHAppIdInAppStore];
    
    [YHHttpTool postNotByJSONDataWithUrl:urlString params:nil success:^(id  _Nonnull responseObj) {
        
        !success ? : success(responseObj);
    } failure:^(NSError * _Nonnull error) {
        !failed ? : failed(error);
    }];
}

- (void)showUpdateNotice{
    
    YHAlertController *alertVc = [YHAlertController alertWithSingleActionTitle:@"提示" message:@"sorry, 请至 appStore下载最新版本,否则不能 team work." cfmBlock:^{
        
        NSURL *url = [NSURL URLWithString:YHAppAddressInAppStore];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)showInternetNotice{
    
    YHAlertController *alertVc = [YHAlertController alertWithSingleActionTitle:@"提示" message:@"请检查网络,稍后重试." cfmBlock:^{
        
        NSURL *url = [NSURL URLWithString:YHAppAddressInAppStore];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [self presentViewController:alertVc animated:YES completion:nil];
}



@end
