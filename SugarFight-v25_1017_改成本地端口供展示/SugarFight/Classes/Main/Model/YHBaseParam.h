//
//  YHBaseParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

///只有uuid, uid
@interface YHBaseParam : NSObject

@property (nonatomic, strong) NSString *uuid;
/** user id */
@property (nonatomic, strong) NSNumber *uid;
@end
