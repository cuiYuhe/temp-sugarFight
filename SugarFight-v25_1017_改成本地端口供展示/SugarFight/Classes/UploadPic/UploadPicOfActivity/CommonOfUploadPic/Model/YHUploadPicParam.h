//
//  YHUploadPicParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUploadPicParam : NSObject

/** uuid 用户的uuid，这个uuid是登录的时候返回的message, 如:"a5e433ac-129f-11e6-821e-c860009ce94c"*/
@property (nonatomic, strong) NSString *uuid;
/** 图片的绝对路径:地址拼接成的字符串，如果有多个地址，用逗号隔开，最后一个不要逗号 */
@property (nonatomic, strong) NSString *img;
/** md5s 图片的MD5码拼接成的字符串，如果有多个MD5码，用逗号隔开最后一个不要逗号 */
@property (nonatomic, strong) NSString *md5s;

@end
