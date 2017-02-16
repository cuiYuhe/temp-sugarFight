//
//  YHPushSubZanModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPushSubZanModel : NSObject

/** imgTime : 20160807*/
@property (nonatomic, strong) NSString *imgTime;
/** YHCategoryType  0:论剑; 1:bcr; 2:battle   */
@property (nonatomic, assign) YHCategoryType category;
@end
