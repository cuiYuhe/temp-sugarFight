//
//  YHShowGuideParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHShowGuideParam : NSObject
/** uid */
@property (nonatomic, strong) NSNumber *uid;
/** 0完美; 1BCR; 2战役 */
@property (nonatomic, assign) YHCategoryType category;

@end
