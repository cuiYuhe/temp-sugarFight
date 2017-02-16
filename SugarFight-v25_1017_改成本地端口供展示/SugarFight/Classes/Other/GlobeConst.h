//
//  GlobeConst.h
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobeConst : NSObject

/** 用户名 */
UIKIT_EXTERN NSString *const YHUsernameKey;
/** 密码 */
UIKIT_EXTERN NSString *const YHPwdKey;

/** OSS地址 */
UIKIT_EXTERN NSString *const YHOSSEndPoint;

/** 标识,曾经打开过最新版本 */
UIKIT_EXTERN NSString *const YHSavedVersion;

/** 6s屏幕宽度 */
UIKIT_EXTERN CGFloat const YHScreenWidthOf6s;
/** 6s plus 屏幕宽度 */
UIKIT_EXTERN CGFloat const YHScreenWidthOf6sPlus;

/** 练习时点击了提交按钮的通知 */
UIKIT_EXTERN NSString *const YHCommitExerciseAnswerNotification;
/** 练习时点击了提交按钮的通知的key */
UIKIT_EXTERN NSString *const YHCommitExerciseAnswerNotificationKey;
/** 上传图片时,成功上传一张时的通知 */
UIKIT_EXTERN NSString *const YHUploadOnePicSucessNotification;
/** 上传图片时,成功上传一张时的通知的key */
UIKIT_EXTERN NSString *const YHUploadOnePicSucessNotificationKey;

/** 格子图片为6张时的collectionView的section的数量 */
UIKIT_EXTERN NSInteger const YHNumberOfSectionsOfGridImages;
/** 格子图片为6张时的collectionView的每个section的列数 */
UIKIT_EXTERN NSInteger const YHNumberOfColumnsInEachSectionOfGridImages;

/** app在appStore中的地址,更新时的url */
UIKIT_EXTERN NSString *const YHAppAddressInAppStore;
/** app在appStore中的id,拿到更新信息的参数 */
UIKIT_EXTERN NSString *const YHAppIdInAppStore;

/** 苹果人员的测试账号'tt1' */
UIKIT_EXTERN NSString *const YHAccountForAppStore;

/** 归档保存标题模型:YHTitlesResult 时的文件名称*/
UIKIT_EXTERN NSString *const YHArchiveTitlesFileName;

@end
