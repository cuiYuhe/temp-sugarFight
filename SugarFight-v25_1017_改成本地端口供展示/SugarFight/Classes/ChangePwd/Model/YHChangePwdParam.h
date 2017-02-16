//
//  YHChangePwdM.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHChangePwdParam : NSObject

/** uid:用户id */
@property (nonatomic, strong) NSNumber *uid;

/** source 来源 a=安卓 / ios=ios */
@property (nonatomic, strong) NSString *source;
/** oldPwd :旧密码 */
@property (nonatomic, strong) NSString *oldPwd;
/** newPwd1:新密码 */
@property (nonatomic, strong) NSString *modifyPwd;
/** newPwd2:新密码的确认密码 */
@property (nonatomic, strong) NSString *cfmPwd;
/** uuid：登陆时返回的token */
@property (nonatomic, strong) NSString *uuid;

@end
