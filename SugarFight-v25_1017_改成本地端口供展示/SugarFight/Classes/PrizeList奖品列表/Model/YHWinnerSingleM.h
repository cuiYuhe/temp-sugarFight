//
//  YHWinnerSingleM.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHWinnerSingleM : NSObject

/**	中奖人 */
@property (nonatomic, copy) NSString *successUser;

/** 奖品 */
@property (nonatomic, copy) NSString *gift;

/** 中奖时间 */
@property (nonatomic, copy) NSString *successTime;

@end
