//
//  YHGetAvatarResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHAvasModel.h"

@interface YHGetAvatarResult : NSObject

/** stuatus": 1, */
@property (nonatomic, strong) NSNumber *stuatus;
/**  "message": "查询成功", */
@property (nonatomic, strong) NSString *message;
/**  "show": 1, */
@property (nonatomic, strong) NSNumber *show;
/**  YHAvasModel array */
@property (nonatomic, strong) NSArray *avas;
@end
