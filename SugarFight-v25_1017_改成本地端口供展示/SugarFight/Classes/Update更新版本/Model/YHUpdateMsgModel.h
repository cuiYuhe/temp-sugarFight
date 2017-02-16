//
//  YHUpdateMsgModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUpdateMsgModel : NSObject
/**
 *  androidDownloadUrl = "http://img.icgear.net/JingPai.apk";
 androidMessage = "\U66f4\U65b0";
 androidVersionCode = "1.0";
 iosDownloadUrl = "http://icgdb.oss-cn-shanghai.aliyuncs.com/per/95394dd0-27da-11e6-9ac6-02004c4f4f50_1464773121580.jpg";
 iosMessage = "\U66f4\U65b0";
 iosVersionCode = "1.0";
 */

/** iosVersionCode */
@property (nonatomic, strong) NSString *iosVersionCode;
/** iosMessage */
@property (nonatomic, strong) NSString *iosMessage;
/** iosDownloadUrl */
@property (nonatomic, strong) NSString *iosDownloadUrl;
@end
