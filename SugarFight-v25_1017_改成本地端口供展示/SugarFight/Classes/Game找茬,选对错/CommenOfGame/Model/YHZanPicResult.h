//
//  YHZanResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHZanPicResult : NSObject

/**
 *   message = "\U5b8c\U7f8e\U5206\U6570\U589e\U52a0";
 show = 1;
 status = 1;
 zanRemain = 4;
 */

/** message */
@property (nonatomic, strong) NSString *message;
/** show */
@property (nonatomic, strong) NSNumber *show;
/** status,1为成功 */
@property (nonatomic, strong) NSNumber *status;
/** zanRemain,剩余赞的数量 */
@property (nonatomic, strong) NSNumber *zanRemain;
@end
