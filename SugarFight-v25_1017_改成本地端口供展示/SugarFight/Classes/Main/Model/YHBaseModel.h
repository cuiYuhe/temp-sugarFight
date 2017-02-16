//
//  YHBaseModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBaseModel : NSObject
/**
 *  message = "\U79ef\U5206\U5df2\U52a00.2";
 show = 0;
 stuatus = 1;
 */
/** 后台提醒信息 */
@property (nonatomic, strong) NSString *message;
/** 备用 */
@property (nonatomic, strong) NSNumber *show;
/** status,使用这个status */
@property (nonatomic, strong) NSNumber *status;

/** stuatus */
@property (nonatomic, strong) NSNumber *stuatus;

/** 后台提醒信息,与message相同. 二者有其一 */
@property (nonatomic, copy) NSString *msg;

@end
