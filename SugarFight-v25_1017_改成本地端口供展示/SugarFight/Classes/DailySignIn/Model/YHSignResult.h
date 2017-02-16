//
//  YHSignResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSignResult : NSObject
/** stuatus, 1 */
@property (nonatomic, strong) NSNumber *stuatus;
/**  "message": "签到成功", */
@property (nonatomic, strong) NSString *message;
/**  "show": 0 */
@property (nonatomic, strong) NSNumber *show;
@end
