//
//  YHGetAvatarSubAvasModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAvasModel : NSObject

/** "refId": 4,对应头像id */
@property (nonatomic, strong) NSNumber *refId;
/** "refValue": 对应头像url */
@property (nonatomic, strong) NSString *refValue;
@end
