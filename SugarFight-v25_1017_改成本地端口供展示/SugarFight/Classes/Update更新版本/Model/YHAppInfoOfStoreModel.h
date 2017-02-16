//
//  YHAppInfoOfStoreModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHAppDetailOfStoreModel.h"

@interface YHAppInfoOfStoreModel : NSObject



/** YHAppDetailOfStoreModel array */
@property (nonatomic, strong) NSArray<YHAppDetailOfStoreModel *> *results;


/** resultCount:1 */
@property (nonatomic, strong) NSNumber *resultCount;

    
@end
