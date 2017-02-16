//
//  NSString+Extension.h
//  testAttributedStr
//
//  Created by Cui yuhe on 16/5/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/** 特殊格式只改变最后一个字,如30张,将'张'改为橙色,字体12 */ 
- (NSAttributedString *)getAttributedStringByConvertingLastCharacter;

/**
 *  是否存在emoji. YES含,NO不含.
 */
- (BOOL)yh_containsEmoji;
@end
