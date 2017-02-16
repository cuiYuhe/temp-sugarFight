//
//  NSArray+Extension.h
//  testString
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

///将string数组转化成,用','隔开的NSString, 如aa,bb,cc
- (NSMutableString *)stringWithStringArray;

@end
