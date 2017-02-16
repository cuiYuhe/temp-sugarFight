//
//  AppDelegate.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "AppDelegate.h"
#import "YHChangePwdVC.h"
#import "YHLoginVC.h"
#import "YHSugarFightWSVC.h"
#import "YHSugarFightNotWSVC.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "YHMyRankingVC.h"
#import "YHNewFeatureVC.h" //新特性
#import "YHUpdateVersionModel.h"  //苹果更新信息model
#import "YHAlertController.h"
#import "YHPopAlertView.h"
#import "JPUSHService.h"
#import "YHPushModel.h"  //推送通知的model
#import "YHCommentsListVC.h" //评论vc
#import "YHSeeHuaShanUploadedVC.h"
#import "YHSeePrideUploadedVC.h"
#import "YHSeeUploadSwordGrideImgVc.h"

static NSString *const YHStrUrlAutoUpdate = @"jianpai/Msg/autoUpdate";
//JPush
static NSString *const appKey = @"bb846cbac9368ce0301d7d22";
static NSString *const channel = @"App Store";
static BOOL const isProduction = YES;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    application.applicationIconBadgeNumber = 0;
    if (launchOptions) {//如果是接收到远程通知打开,直接跳转根vc
        [GlobeSingle shareGlobeSingle].remoteNote = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置推送
    [self setupJPush:launchOptions];
    
    ///选择根控制器
    [self chooseRootVc];
    
    return YES;
}

///选择根控制器
- (void)chooseRootVc{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];

    //检查是否第一次使用当前版本app
    BOOL isOpenFirst = [self checkIfOpenNewVersionFirst:currentVersion];
    
    if (isOpenFirst) { //第一次打开此版本
        YHNewFeatureVC *vc = [[YHNewFeatureVC alloc] init];
        self.window.frame = [UIScreen mainScreen].bounds;
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
        
        //提示用户更新信息
        [self getUpdateInfoFromServer];
    }else{//不是第一次打开此版本
        //跳到登录界面,因为sb中已设置loginVc为首vc,所以可以什么都不做.
        return;
    }
}

//建立JPush
- (void)setupJPush:(NSDictionary *)launchOptions{
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
    }else{
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    //Required
    //    如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction];

}

//4.检查是不是第一次打开新版本
- (BOOL)checkIfOpenNewVersionFirst:(NSString *)currentVersion{
    
    //1.得到保存的版本标识
    NSUserDefaults *userDft = [NSUserDefaults standardUserDefaults];
    NSString *savedVersion = [userDft objectForKey:YHSavedVersion];
    if ([currentVersion isEqualToString:savedVersion]) { //版本号相同,表明不是新版本
        return NO;
    }
    
    //2.保存版本
    [userDft setObject:currentVersion forKey:YHSavedVersion];
    return YES;
}

///从服务器得到更新信息
- (void)getUpdateInfoFromServer{
    //不要用自己的更新
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlAutoUpdate params:nil success:^(id  _Nonnull responseObj) {
        YHUpdateVersionModel *updateM = [YHUpdateVersionModel mj_objectWithKeyValues:responseObj];
        if (updateM.status.integerValue == 1) {
            
            YHAlertController *alertVc = [YHAlertController alertWithTitle:@"更新信息" message:updateM.updateMsg.iosMessage singleActionTitle:@"确定"];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        YHLog(@"获取版本信息失败");
    }];
}

//内存警告
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache cleanDisk];
}

#pragma mark ------------------------------------------
#pragma mark JPush methods
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    if (application.applicationState == UIApplicationStateActive) {
        YHLog(@"active,接收到远程通知userInfo--");
        
        application.applicationIconBadgeNumber = 0;
        
        ///接收到远程通知后的操作
        [self setupAfterGetApsWithNotification:userInfo];
        
    }else if(application.applicationState == UIApplicationStateBackground){
        //程序处于后台,没有这个模式
        YHLog(@"没有这个模式,这对大括号代码都不会执行----UIApplicationStateBackground");
         [self setupAfterGetApsWithNotification:userInfo];
        
    }else if (application.applicationState == UIApplicationStateInactive ){
        YHLog(@"UIApplicationStateInactive");
        
        ///接收到远程通知后的操作
        if ([GlobeSingle shareGlobeSingle].remoteNote == nil) {//为空证明不是当前app不是由死到生
            [self setupAfterGetApsWithNotification:userInfo];
        }else{//由死到生,什么都不用做,自动会加载根vc:登录vc
            
        }
    }
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    YHLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

///接收到远程通知后的操作
- (void)setupAfterGetApsWithNotification:(NSDictionary *)userInfo{
    YHLog(@"userInfo = %@", userInfo);
    YHPushModel *pushM = [YHPushModel mj_objectWithKeyValues:userInfo];
    
    YHPopAlertView *popAlertView = nil;
    WeakSelf
    //1.需要跳转界面的推送
    if (pushM.PING || pushM.ZAN) {
        
        popAlertView = [YHPopAlertView popAlertViewOfNotificationWithContent:pushM.aps.alert cfm:^{
            
            if (pushM.PING) {//PING有值,是收到评论的通知
                //跳转到评论列表界面
                YHCommentsListVC *commentsVc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHCommentsListVC class])];
                
                [weakSelf jumpToTriggeredVcByAps:commentsVc remotePushM:pushM];
            }else if (pushM.ZAN){
                
                //确定哪个上传图片vc
                NSString *sbString = nil;
                switch (pushM.ZAN.category) {
                    case YHCategoryTypeHuaShanPerfect:
                        sbString = NSStringFromClass([YHSeeHuaShanUploadedVC class]);
                        break;
                    case YHCategoryTypePrideBcr:
                        sbString = NSStringFromClass([YHSeePrideUploadedVC class]);
                        break;
                    case YHCategoryTypeBattleGridImages:
                        sbString = NSStringFromClass([YHSeeUploadSwordGrideImgVc class]);
                        break;
                        
                    default:
                        break;
                }
                
                YHTriggeredByNoteVc *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:sbString];
                [weakSelf jumpToTriggeredVcByAps:vc remotePushM:pushM];
            }
            
        } cancel:nil];
    }
    
    //2.需要跳转界面的推送
    if (pushM.MSG){
        popAlertView = [YHPopAlertView popAlertViewSingleBtnWithTitle:pushM.MSG.title content:pushM.MSG.message cfm:nil];
    }
    
    [popAlertView show];
}

///接收到远程通知后,跳转到相应的vc
- (void)jumpToTriggeredVcByAps:(YHTriggeredByNoteVc *)vc remotePushM:(YHPushModel *)pushM{
    
    vc.pushM = pushM;
    UIViewController *topVc = [[GlobeSingle shareGlobeSingle] getTopVc];
    
      if ([topVc isKindOfClass:[vc class]]) {//如果vc是YHCommentsListVC,则[vc class]就是YHCommentsListVC.
          
        //如果当前rootVc就是评论列表vc,则不需要切换rootVc,如果切换则当前vc像死了一样,不能返回了.所以只要重新刷新数据即可.
        YHTriggeredByNoteVc *jumpToVc = (YHTriggeredByNoteVc *)topVc;
        jumpToVc.reloadNetworkData = YES;
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    }
}

/**
 *  给过程推送跳转的vc赋值
 *
 *  @param vc      将要跳转到的vc
 *  @param vcClass 将要跳转到的vc的class
 *  @param pushM   推送模型
 */
- (void)jumpToTriggeredVcByAps:(YHTriggeredByNoteVc *)vc vcClass:(Class)vcClass remotePushM:(YHPushModel *)pushM{
    
}

@end
