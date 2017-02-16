//
//  NSCalendar+Init.m
//  日期处理2
//
//  Created by Cui yuhe on 14/1/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "NSCalendar+Init.h"

@implementation NSCalendar (Init)

+ (instancetype)cat_calendar{
    
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        
        //如果在iOS高版本中,有下方法定义calendar对象可能会有错误.
        return [NSCalendar currentCalendar];
    }
}

@end
