//
//  YHSingleImgParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSingleImgParam : NSObject

/** 图片的绝对路径:地址拼接成的字符串，如果有多个地址，用逗号隔开，最后一个不要逗号 */
@property (nonatomic, strong) NSString *imgUrl;
/** md5s 图片的MD5码拼接成的字符串，如果有多个MD5码，用逗号隔开最后一个不要逗号 */
@property (nonatomic, strong) NSString *imgMd5;

@end
