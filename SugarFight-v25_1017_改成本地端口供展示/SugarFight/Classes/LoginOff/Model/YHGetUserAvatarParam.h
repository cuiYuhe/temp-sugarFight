//
//  YHGetUserIconParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetUserAvatarParam : NSObject

/** uid	Integer	用户的id	1 */
@property (nonatomic, strong) NSNumber *uid;
/** token	String	用户的token，即用户的uuid，
 这个token是登录的时候返回的message	"a5e433ac-129f-11e6-821e-c860009ce94c" */
@property (nonatomic, strong) NSString *token;
/** userAvatarId	Integer	用户的头像id，即用户登录时返回的头像id	1 */
@property (nonatomic, strong) NSNumber *userAvatarId;

@end
