//
//  YHGetUserIconResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHGetUserAvatarResultSubRef.h"

@interface YHGetUserAvatarResult : NSObject

/** stuatus */
@property (nonatomic, strong) NSNumber *stuatus;
/** "message": "头像信息", */
@property (nonatomic, strong) NSString *message;
/** "show": 1, */
@property (nonatomic, strong) NSNumber *show;
/** ref */
@property (nonatomic, strong) YHGetUserAvatarResultSubRef *ref;


@end
