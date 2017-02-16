//
//  YHDateTool.h
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDateTool : NSObject
SingleH(DateTool)

//得到传入的数字年份的天数.
+ (NSUInteger)daysOfYear:(NSInteger)year;

//传入日期,得到年份
- (NSInteger)getYear:(NSDate *)date;

//传入日期,得到月份
- (NSInteger)getMonth:(NSDate *)date;

/**
 *  得到传入天的日期
 *  @param day 今年的第几天,从0开始
 *  @return 日期
 */
- (NSString *)getDateStrWithDayOfThisYear:(NSInteger)day;

/**
 *  得到传入天的日期
 *
 *  @param day 这个月的第几天,从0开始
 *
 *  @return 日期
 */
- (NSString *)getDateStrWithDayOfThisMonth:(NSInteger)day;
/**
 *  得到传入天的星期
 *
 *  @param day 今年的第几天,从0开始
 *
 *  @return 星期
 */
- (NSString *)getWeekdayStrWithDayOfThisYear:(NSInteger)day;

/**
 *  得到传入天的星期
 *
 *  @param day 当月的第几天,从0开始
 *
 *  @return 星期
 */
- (NSString *)getWeekdayStrWithDayOfThisMonth:(NSInteger)day;


/**
 *   得到当前日期是今年的第几天
 *
 *  @return 今天是今年的第几天
 */
- (NSInteger)getTodayIndexOfThisYear;

/** @return 今天是当月的第几天 */
- (NSInteger)getTodayIndexOfThisMonth;

///是否是同一天
//- (BOOL)isSameDay:(NSDate *)date anotherDate:(NSDate *)anotherDate;

/**
 *  根据特定的日期,得到日期的字符串.注意,日期格式 年月日 必须是全的.
 *
 *  @param dateFormate 日期格式,如@"yyyy-MM-dd"
 *  @param date        哪一个日期
 *
 *  @return 日期字符串
 */
- (NSString *)getDateStringWithFullDateFormat:(NSString *)dateFormate date:(NSDate *)date;

/**
 *  根据特定的日期,得到NSDate
 *
 *  @param dateFormat 日期格式
 *  @param date       哪个日期string
 *
 *  @return 日期NSDate
 */
- (NSDate *)getDateWithDateFormat:(NSString *)dateFormat date:(NSString *)dateStr;

/**
 *  根据特定的日期,得到日期的字符串.注意,日期格式 月日 MMdd.
 *
 *  @param dateFormate 日期格式,如@"MM-dd"
 *  @param date        哪一个日期
 *
 *  @return 日期字符串
 */
- (NSString *)getCurrentDateStringWithPartDateFormat:(NSString *)dateFormate date:(NSDate *)date;

- (NSString *)getCurrentDateStringWithOldPartDateFormat:(NSString *)oldDateFormate newFullDateFormate: (NSString *)newDateFormate dateString: (NSString *)dateStr;

/**
 *  得到一个特定日期
 *
 *  @param year  年,如2016
 *  @param month 月, 如5
 *  @param day   日, 如1
 *
 *  @return 返回一个NSDate,再根据getDateStringWithDateFormat方法即可得到字符串
 */
- (NSDate *)getSpecifiedDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 *  根据A格式的日期字符串,得到B格式的日期字符串
 *
 *  @param dateString      日期字符串
 *  @param fromDateFormate 本来的日期格式,即上述A格式
 *  @param toDateFormate   转化成目标的日期格式,即上述B格式
 *
 *  @return 指定格式的日期字符串
 */
- (NSString *)convertToSpecifiedDateWithDateString:(NSString *)dateString FromDateFormate:(NSString *)fromDateFormate toDateFormate:(NSString *)toDateFormate;

///第一天会周几,
- (NSInteger)firstWeekdayInMonth:(NSDate *)date;

//得到月的天数
- (NSInteger)totalDaysInMonth:(NSDate *)date;

- (NSDate *)lastMonth:(NSDate *)date;

- (NSDate*)nextMonth:(NSDate *)date;

@end












