//
//  GlobeConst.m
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "GlobeConst.h"

@implementation GlobeConst


/** 用户名  */
NSString *const YHUsernameKey = @"YHloginUsername";
/** 密码 */
NSString *const YHPwdKey = @"YHloginPwd";

/** OSS地址 */
NSString *const YHOSSEndPoint = @"http://img.icgear.net/";

/** 标识,曾经打开过最新版本 */
NSString *const YHSavedVersion = @"YHSavedVersion";

/** 6s屏幕宽度 */
CGFloat const YHScreenWidthOf6s = 375.0f;
/** 6s plus 屏幕宽度 */
CGFloat const YHScreenWidthOf6sPlus = 414.0f;

/** 练习时点击了提交按钮的通知 */
NSString *const YHCommitExerciseAnswerNotification = @"YHCommitExerciseAnswerNotification";
/** 练习时点击了提交按钮的通知的key */
NSString *const YHCommitExerciseAnswerNotificationKey = @"YHCommitExerciseAnswerNotificationKey";
/** 上传图片时,成功上传一张时的通知 */
NSString *const YHUploadOnePicSucessNotification = @"YHUploadOnePicSucessNotification";
/** 上传图片时,成功上传一张时的通知的key */
NSString *const YHUploadOnePicSucessNotificationKey = @"YHUploadOnePicSucessNotificationKey";


/** 格子图片为6张时的collectionView的section的数量 */
NSInteger const YHNumberOfSectionsOfGridImages = 3;
/** 格子图片为6张时的collectionView的每个section的列数 */
NSInteger const YHNumberOfColumnsInEachSectionOfGridImages = 2;

/** app在appStore中的地址 */
NSString *const YHAppAddressInAppStore = @"itms-apps://itunes.apple.com/cn/app/quan-tang-zheng-ba/id1124805920?mt=8";
/** app在appStore中的id,拿到更新信息的参数 */
NSString *const YHAppIdInAppStore = @"1124805920";

/** 苹果人员的测试账号'tt1' */
NSString *const YHAccountForAppStore = @"tt1";


/** 归档保存标题模型:YHTitlesResult 时的文件名称*/
NSString *const YHArchiveTitlesFileName = @"YHArchiveTitlesFileName";

@end
