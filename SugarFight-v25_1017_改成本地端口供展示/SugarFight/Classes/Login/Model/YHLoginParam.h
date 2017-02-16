//
//  YHLoginParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHLoginParam : NSObject

/** userName":"user1", */
@property (nonatomic, copy) NSString *userName;

/** "userPwd":"123456", */
@property (nonatomic, copy) NSString *userPwd;

/** “currentVersion”:1.8, */
@property (nonatomic, copy) NSString *currentVersion;

/** ”platform”:IOS/ANDROID */
@property (nonatomic, copy) NSString *platform;
@end
