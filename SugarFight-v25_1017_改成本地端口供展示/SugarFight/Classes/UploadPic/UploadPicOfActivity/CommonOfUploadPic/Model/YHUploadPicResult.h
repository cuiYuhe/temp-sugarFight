//
//  YHUploadPicResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHUploadPicStatusType) {
    YHUploadPicStatusTypeError,
    YHUploadPicStatusTypeSuccess = 1,
    YHUploadPicStatusTypeAlreadyUploaded,
};


@interface YHUploadPicResult : NSObject

/** stuatus, 为1时为正确 */
@property (nonatomic, strong) NSNumber *stuatus;
/** message */
@property (nonatomic, strong) NSString *message;
/** show */
@property (nonatomic, strong) NSNumber *show;
/** YHUploadPicStatusType */
@property (nonatomic, assign) YHUploadPicStatusType uploadPicStatus;
@end
