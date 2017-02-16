//
//  YHZanCommentParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHZanCommentParam : NSObject
/**
 *  params	String	参数对象封装成的JSON字符串	{
 did:12,
 uid:13,
 token:"sdfsd-sfss-sf",
 pingId:23
 }
 */

/** 所顶评论,这个评论的评论人的id */
@property (nonatomic, strong) NSNumber *did;
///当前用户id
@property (nonatomic, strong) NSNumber *uid;
///当前用户uuid
@property (nonatomic, strong) NSString *token;
///评论id
@property (nonatomic, strong) NSNumber *pingId;

@end
