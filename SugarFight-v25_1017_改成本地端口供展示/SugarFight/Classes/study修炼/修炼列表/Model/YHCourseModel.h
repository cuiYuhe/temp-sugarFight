//
//  YHCourseModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCourseModel : NSObject

/** courseDiscription */
@property (nonatomic, copy) NSString *courseDiscription;
/** courseId = 1 */
@property (nonatomic, assign) NSInteger courseId;
/** courseName */
@property (nonatomic, copy) NSString *courseName;
/** courseScore, 为-1时不显示 */
@property (nonatomic, assign) NSInteger courseScore;
@end
