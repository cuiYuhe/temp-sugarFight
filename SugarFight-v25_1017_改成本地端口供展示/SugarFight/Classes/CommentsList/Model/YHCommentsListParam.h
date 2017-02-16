//
//  YHCommentParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCommentsListParam : NSObject
/**
 *  imgUrl和category必须传，如果有多张图片，则传第一张图片（即imgBiao为0或3的那张）;
 */
/** 如果有多张图片，则传第一张图片（即imgBiao为0或3的那张） */
@property (nonatomic, strong) NSString *imgUrl;
/** 0:论剑;  1:bcr */
@property (nonatomic, strong) NSNumber *category;
/** imgId没有可以不传 */
@property (nonatomic, strong) NSNumber *imgId;
@end
