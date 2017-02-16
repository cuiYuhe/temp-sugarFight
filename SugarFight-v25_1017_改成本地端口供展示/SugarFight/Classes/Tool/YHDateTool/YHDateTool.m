//
//  YHDateTool.m
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDateTool.h"

@interface YHDateTool()
/** calendar */
//@property (nonatomic, strong) NSCalendar *calendar;
/** 星期的数组 */
@property (nonatomic, strong) NSArray *weekdays;
/** date声明 */
@property (nonatomic, strong) NSDate *date;
/** date fmt */
@property (nonatomic, strong) NSDateFormatter *fmt;

@end

@implementation YHDateTool
SingleM(DateTool)

#pragma mark ------------------------------------------
#pragma mark lazy
- (NSCalendar *)calendar{
    static NSCalendar *calendar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setFirstWeekday:1];
    });
    return calendar;
}

- (NSArray *)weekdays{
    if (!_weekdays) {
        _weekdays = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    }
    return _weekdays;
}

- (NSDate *)date{
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

- (NSDateFormatter *)fmt{
    if (!_fmt) {
        _fmt = [[NSDateFormatter alloc] init];
    }
    return _fmt;
}

#pragma mark ------------------------------------------
#pragma mark methods
//返回当地时间,默认得到时间与中国系统时间相差8h.注:如果用得到的时间计算星期则不准确.
- (NSDate *)getLocalDate: (NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

//得到传入的数字年份的天数.
+ (NSUInteger)daysOfYear:(NSInteger)year{
    
    BOOL leap;//bool 用来判断是否是闰年
    
    if(year % 4 != 0)
        leap = false;
    else if(year % 100 != 0)
        leap = true;
    else if(year % 400 != 0)
        leap = false;
    else
        leap = true;
    
    if(leap)//判断leap是否为真
        return 366;
    else
        return 365;
}

//传入日期,得到年份
- (NSInteger)getYear:(NSDate *)date{
    return [self.calendar components:NSCalendarUnitYear fromDate:date].year;
}

//传入日期,得到月份
- (NSInteger)getMonth:(NSDate *)date{
    return [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date].month;
}

//传入日期,得到哪天
- (NSInteger)getDay:(NSDate *)date{
    return [self.calendar components:NSCalendarUnitYear | NSCalendarUnitDay fromDate:date].day;
}

//传入日期,周几
- (NSUInteger)getWeekday2:(NSDate *)date{
    //星期日 对应 1; 星期一 对应 2
    return [self.calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfYear forDate:date];
}

//得到日期date的星期
- (NSUInteger)getWeekday: (NSDate *)date{
    //星期日 对应 1; 星期一 对应 2
    NSDateComponents *cmps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return cmps.weekday;
}

- (NSString *)getWeekdayStr: (NSDate *)date{
    NSUInteger index = [self getWeekday:date] - 1;
    return self.weekdays[index];
}

//根据当年的第几天得到日期
- (NSString *)getDateStrWithDayOfThisYear:(NSInteger)day{
    NSDateComponents *comp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger currentYear = [self getYear:self.date];
    [comp setYear:currentYear];
    [comp setMonth:1];
    [comp setDay:1];
    NSDate *firstDayOfThisYear = [self.calendar dateFromComponents:comp];
    //    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //1.得到日期, 4月2日
    fmt.dateFormat = @"M月d日";
    NSDate *targetDate = [NSDate dateWithTimeInterval:day * 3600 * 24 sinceDate:firstDayOfThisYear];
    //1.得到日期, 4月2日
    NSString *dateStr = [fmt stringFromDate:targetDate];
    return dateStr;
}

//得到本月的第几天对应的日期
- (NSString *)getDateStrWithDayOfThisMonth:(NSInteger)day{

    NSDateComponents *comp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger currentYear = [self getYear:self.date];
    NSInteger currentMonth = [self getMonth:self.date];
    [comp setYear:currentYear];
    [comp setMonth:currentMonth];
    [comp setDay:1];
    NSDate *firstDayOfThisYear = [self.calendar dateFromComponents:comp];
    //    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //1.得到日期, 4月2日
    fmt.dateFormat = @"M月d日";
    NSDate *targetDate = [NSDate dateWithTimeInterval:day * 3600 * 24 sinceDate:firstDayOfThisYear];
    //1.得到日期, 4月2日
    NSString *dateStr = [fmt stringFromDate:targetDate];
    return dateStr;
}

//得到传入天的星期
- (NSString *)getWeekdayStrWithDayOfThisYear:(NSInteger)day{
    NSDateComponents *comp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger currentYear = [self getYear:self.date];
    [comp setYear:currentYear];
    [comp setMonth:1];
    [comp setDay:1];
    NSDate *firstDayOfThisYear = [self.calendar dateFromComponents:comp];
    //    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //1.得到日期, 4月2日
    fmt.dateFormat = @"M月d日";
     NSString *weekStr = nil;
    NSDate *targetDate = [NSDate dateWithTimeInterval:day * 3600 * 24 sinceDate:firstDayOfThisYear];
    //1.得到日期, 4月2日
//    NSString *dateStr = [fmt stringFromDate:targetDate];
    
    //2.得到星期
    NSUInteger weekday = [self getWeekday:targetDate];
    
    if (weekday == 1) { //周日
        weekStr = self.weekdays[0];
    }else{
        weekStr = self.weekdays[weekday - 1];
    }
    return weekStr;
}

//得到传入天的星期
- (NSString *)getWeekdayStrWithDayOfThisMonth:(NSInteger)day{
    NSDateComponents *comp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger currentYear = [self getYear:self.date];
    NSInteger currentMonth = [self getMonth:self.date];
    [comp setYear:currentYear];
    [comp setMonth:currentMonth];
    [comp setDay:1];
    NSDate *firstDayOfThisMonth = [self.calendar dateFromComponents:comp];
    //    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //1.得到日期, 4月2日
    fmt.dateFormat = @"M月d日";
    NSString *weekStr = nil;
    NSDate *targetDate = [NSDate dateWithTimeInterval:day * 3600 * 24 sinceDate:firstDayOfThisMonth];
    //1.得到日期, 4月2日
    //    NSString *dateStr = [fmt stringFromDate:targetDate];
    
    //2.得到星期
    NSUInteger weekday = [self getWeekday:targetDate];
    
    if (weekday == 1) { //周日
        weekStr = self.weekdays[0];
    }else{
        weekStr = self.weekdays[weekday - 1];
    }
    //    YHLog(@"dateStr = %@, weekStr = %@", dateStr, weekStr);
    return weekStr;
}

//今天是今年的第几天
- (NSInteger)getTodayIndexOfThisYear{
    //1.1 得到当前日期是今年的第几天
    self.fmt.dateFormat = @"D";
    NSString *dateStr = [self.fmt stringFromDate:self.date];
    return dateStr.integerValue;
}

//今天是当月的第几天
- (NSInteger)getTodayIndexOfThisMonth{
    //1.1 得到当前日期是当月的第几天
    self.fmt.dateFormat = @"d";
    NSString *dateStr = [self.fmt stringFromDate:self.date];
    return dateStr.integerValue;
}

- (NSCalendar *)cat_calendar{
    
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        
        //如果在iOS高版本中,有下方法定义calendar对象可能会有错误.
        return [NSCalendar currentCalendar];
    }
}

///是否是同一天
- (BOOL)isSameDay:(NSDate *)date anotherDate:(NSDate *)anotherDate{
        
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:anotherDate];
//    
//    BOOL b1 =[comp1 day]   == [comp2 day];
//    BOOL b2 =[comp1 month]   == [comp2 month];
//    BOOL b3 =[comp1 year]   == [comp2 year];
//    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

///根据特定的日期,得到日期的字符串
- (NSString *)getDateStringWithFullDateFormat:(NSString *)dateFormate date:(NSDate *)date{
    self.fmt.dateFormat = dateFormate;
     [self.fmt setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/BeiJing"]];
    return [self.fmt stringFromDate:date];
}

/**
 *  根据特定的日期,得到NSDate
 */
- (NSDate *)getDateWithDateFormat:(NSString *)dateFormat date:(NSString *)dateStr{
    
    self.fmt.dateFormat = dateFormat;
    return [self.fmt dateFromString:dateStr];
}

- (NSString *)convertToSpecifiedDateWithDateString:(NSString *)dateString FromDateFormate:(NSString *)fromDateFormate toDateFormate:(NSString *)toDateFormate{
    NSDate *fromDate = [self getDateWithDateFormat:fromDateFormate date:dateString];
    self.fmt.dateFormat = toDateFormate;
    return [self.fmt stringFromDate:fromDate];
}

///根据特定的日期,得到日期的字符串.注意,日期格式 月日 必须是全的.
- (NSString *)getCurrentDateStringWithPartDateFormat:(NSString *)dateFormate date:(NSDate *)date{
    NSInteger currentYear = [self getYear:self.date];
    NSInteger month = [self getMonth:date];
    NSInteger day = [self getDay:date];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:currentYear];
    [comp setMonth:month];
    [comp setDay:day];
    NSDate *currentYearDate = [self.calendar dateFromComponents:comp];
    return [self getDateStringWithFullDateFormat:dateFormate date:currentYearDate];
}

- (NSString *)getCurrentDateStringWithOldPartDateFormat:(NSString *)oldDateFormate newFullDateFormate: (NSString *)newDateFormate dateString: (NSString *)dateStr{
    //得到旧日期格式的NSDate
    self.fmt.dateFormat = oldDateFormate;
    NSDate *date = [self.fmt dateFromString:dateStr];
    
    return [self getCurrentDateStringWithPartDateFormat:newDateFormate date:date];
}

///  得到一个特定日期
- (NSDate *)getSpecifiedDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    return [self.calendar dateFromComponents:comp];
}

/**
 *  ///////////////////////////
 */
- (NSInteger)firstWeekdayInMonth:(NSDate *)date{
    
    [self.calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [self.calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totalDaysInMonth:(NSDate *)date{
    NSRange daysInMonth = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [self.calendar dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [self.calendar dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

@end
