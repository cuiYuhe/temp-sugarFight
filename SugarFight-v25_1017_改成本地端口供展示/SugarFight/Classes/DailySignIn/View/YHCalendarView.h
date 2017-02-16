//
//  YHCalendarView.h
//  testCalendarOfSugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHCalendarView : UIView

/** 签到的日期数组 */
{
    NSMutableArray *_signInDays;
}
/** 日期:月份是欲显示签到的月份,date不设置会报错,重写get方法处理 */
@property (nonatomic, strong) NSDate *date;

- (void)setSignInDays:(NSMutableArray *)signInDays;
- (NSMutableArray *)signInDays;

@end
