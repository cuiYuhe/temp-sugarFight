//
//  YHGetMyAppellationParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetMyAppellationParam : NSObject

/** uid	Integer	用户id	1 */
@property (nonatomic, strong) NSNumber *uid;
/** uuid, 用户的token，即登录时返回的message "a5e433ac-129f-11e6-821e-c860009ce94c" */
@property (nonatomic, strong) NSString *uuid;

@end
