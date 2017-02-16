//
//  NSDate+Interval.m
//  日期处理2
//
//  Created by Cui yuhe on 14/1/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "NSDate+Interval.h"
#import "NSCalendar+Init.h"

/************* 辅助类 CATDateInterval - begin *******************/

@implementation CATDateInterval

@end

/************* 辅助类 CATDateInterval - end *********************/

@implementation NSDate (Interval)

- (BOOL)cat_isInToday{
    
    NSCalendar *calendar = [NSCalendar cat_calendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    // NSDateComponents内部重写了isEqual:, 只要各种元素一样, isEqual:就返回YES
    //isEqual:默认是比较二者的地址
    
    return [nowCmps isEqual:selfCmps];
}

- (BOOL)cat_isInYesterday{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    //设置为下格式,其它的时分秒被舍弃
    fmt.dateFormat = @"yyyyMMdd";
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    // 生成只有年月日的日期(没有时分秒, 时分秒已经被抛弃了)
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSCalendar *calendar = [NSCalendar cat_calendar];
    
    //得到日期之差
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

- (BOOL)cat_isInTomorrow{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyyMMdd";
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [[NSCalendar cat_calendar]components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1;
}

- (BOOL)cat_isInThisYear{
    
    NSCalendar *calendar = [NSCalendar cat_calendar];
    
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    // NSDateComponents内部重写了isEqual:, 只要各种元素一样, isEqual:就返回YES
    //isEqual:默认是比较二者的地址
    return [nowCmps isEqual:selfCmps];
}

- (CATDateInterval *)cat_dateIntervalSinceDate:(NSDate *)anotherDate{
    
    NSInteger interval = [self timeIntervalSinceDate:anotherDate];
    
    NSInteger secsPerMinute = 60;
    NSInteger secsPerHour = 60 * secsPerMinute;
    NSInteger secsPerDay = 24 * secsPerHour;
    
    CATDateInterval *dateInterval = [[CATDateInterval alloc]init];
    dateInterval.day = interval / secsPerDay;
    dateInterval.hour = (interval % secsPerDay) / secsPerHour;
    dateInterval.minute = (interval % secsPerDay % secsPerHour) / secsPerMinute;
    dateInterval.second = interval % secsPerMinute;
    
    return dateInterval;
}







@end
