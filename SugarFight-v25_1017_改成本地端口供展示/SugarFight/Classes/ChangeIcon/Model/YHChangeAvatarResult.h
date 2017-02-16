//
//  YHChangeAvatarResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHChangeAvatarResult : NSObject

/** "stuatus": 1, */
@property (nonatomic, strong) NSNumber *stuatus;
/**  "message": "头像更新成功", */
@property (nonatomic, strong) NSString *message;
/**  "show": 1 */
@property (nonatomic, strong) NSString *show;
@end
