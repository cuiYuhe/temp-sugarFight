//
//  YHGetMyAppellationResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetMyAppellationResult : NSObject

/** success = 1; 是否成功 */
@property (nonatomic, strong) NSNumber *success;
/** 笑傲江湖 被赞数量 */
@property (nonatomic, strong) NSNumber *bcrLikedNumber;
/** 笑傲江湖 上传数量 */
@property (nonatomic, strong) NSNumber *bcrUploadNumber;
/** 华山论剑 被赞数量 */
@property (nonatomic, strong) NSNumber *preLikedNumber;
/** 华山论剑 上传数量 */
@property (nonatomic, strong) NSNumber *preUploadNumber;
/** 总上传数量 */
@property (nonatomic, strong) NSNumber *totalUploadNumber;

@end
