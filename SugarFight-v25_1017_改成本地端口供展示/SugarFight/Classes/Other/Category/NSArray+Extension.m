//
//  NSArray+Extension.m
//  testString
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (NSMutableString *)stringWithStringArray{
    
    NSMutableString *str = [NSMutableString string];
    NSString *interval = @",";
    for (NSString *string in self) {
        [str appendString:string];
        [str appendString:interval];
    }
    
    if (self.count > 0) {
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    return str;
}

@end
