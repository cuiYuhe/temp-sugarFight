//
//  YHMd5CheckParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHMd5CheckParam : NSObject

/** md	所有的MD5码拼接成的字符串，拼接方法，MD5字符串,如果有多个，用逗号隔开，最后一个不要逗号	ASDFAS23424,1234234214,1234214 */
@property (nonatomic, copy) NSString *md;
/** uid,可选参数:判断是否可以上传 */
@property (nonatomic, strong) NSNumber *uid;
/** 0完美;1BCR;2战役 可选参数:判断是否可以上传 */
@property (nonatomic, assign) YHCategoryType category;


@end
