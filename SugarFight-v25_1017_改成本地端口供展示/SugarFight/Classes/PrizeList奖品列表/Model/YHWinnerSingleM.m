//
//  YHWinnerSingleM.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHWinnerSingleM.h"
#import "YHDateTool.h"

@implementation YHWinnerSingleM

- (void)setSuccessTime:(NSString *)successTime{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:successTime.doubleValue / 1000];
    NSString *dateStr = [[YHDateTool shareDateTool] getDateStringWithFullDateFormat:@"yyyy/MM/dd HH:mm:ss" date:date];
    _successTime = dateStr;
    
}
@end
