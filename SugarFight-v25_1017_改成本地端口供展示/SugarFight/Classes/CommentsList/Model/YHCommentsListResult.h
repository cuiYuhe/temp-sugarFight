//
//  YHCommentResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHCommentModel;

@interface YHCommentsListResult : NSObject

/** <#注释#> */
@property (nonatomic, strong) NSString *message;
/** <#注释#> */
@property (nonatomic, strong) NSNumber *stuatus;
/** <#注释#> */
@property (nonatomic, strong) NSNumber *show;
/** 评论模型 */
@property (nonatomic, strong) NSArray<YHCommentModel *> *pings;


 
@end
