//
//  YHZanParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHZanPicParam : NSObject

/** category, 0:论剑;  1:bcr,笑傲江湖 */
@property (nonatomic, strong) NSNumber *category;
/** puid,当前被赞图片的主人的id,来自获取图片的接口 */
@property (nonatomic, strong) NSNumber *puid;
/** token,用户登录时返回的token.艹,一会uuid,一会token */
@property (nonatomic, strong) NSString *token;
/** uid,点赞的用户id */
@property (nonatomic, strong) NSNumber *uid;
/** 被点赞图片的id */
@property (nonatomic, strong) NSNumber *imgId;
@end
