//
//  NSDate+Interval.h
//  日期处理2
//
//  Created by Cui yuhe on 14/1/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

/************* 辅助类 CATDateInterval - begin *******************/
@interface CATDateInterval : NSObject

/** 日期间相隔天数 */
@property (nonatomic, assign) NSInteger day;

/** 日期间相隔小时数 */
@property (nonatomic, assign) NSInteger hour;

/** 日期间相隔分钟数 */
@property (nonatomic, assign) NSInteger minute;

/** 日期间相隔秒数 */
@property (nonatomic, assign) NSInteger second;

@end
/************* 辅助类 CATDateInterval - end *******************/

@interface NSDate (Interval)

- (BOOL)cat_isInToday;
- (BOOL)cat_isInYesterday;
- (BOOL)cat_isInTomorrow;
- (BOOL)cat_isInThisYear;


- (__kindof CATDateInterval *)cat_dateIntervalSinceDate:(NSDate *)anotherDate;

@end






