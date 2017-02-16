//
//  YHRealScoreDetailModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHRealScoreDetailModel.h"
#import "YHScoreDetailModel.h"

@interface YHRealScoreDetailModel : NSObject
/** status */
@property (nonatomic, strong) NSNumber *status;
/** scoreDetail */
@property (nonatomic, strong) YHScoreDetailModel *scoreDetail;
/** message,不用.0531 */
@property (nonatomic, strong) NSString *message;
/** 不用.0531 */
@property (nonatomic, strong) NSNumber *loginStatus;
/** 不用.0531 */
@property (nonatomic, strong) NSNumber *scoreChange;
@end

