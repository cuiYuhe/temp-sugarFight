//
//  YHChangePwdModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHChangePwdModel : NSObject

/** stuatus, 3代表成功 */
@property (nonatomic, strong) NSString *stuatus;
/** "message": "密码修改成功" */
@property (nonatomic, strong) NSString *message;
/** "show": 0 */
@property (nonatomic, strong) NSNumber *show;
@end
