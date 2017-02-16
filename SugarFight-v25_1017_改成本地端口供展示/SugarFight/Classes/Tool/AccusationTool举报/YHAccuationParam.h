//
//  YHAccuationParma.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAccuationParam : NSObject
/** 举报人id */
@property (nonatomic, strong) NSNumber *uid;
/** 图片id,举报图片时传 */
@property (nonatomic, strong) NSNumber *iid;
/** 图片id,举报评论时传 */
@property (nonatomic, strong) NSNumber *pid;
/** 举报信息 */
@property (nonatomic, strong) NSString *msg;
@end
