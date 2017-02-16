//
//  YHGetSignInfoResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetSignInfoResult : NSObject

/**  success	请求是否成功：成功true，失败：false */
@property (nonatomic, strong) NSString *success;
/**  message	返回信息 */
@property (nonatomic, strong) NSString *message;
/**  score	签到累计得分 */
@property (nonatomic, strong) NSNumber *score;
/**  signTimes::[1,2,3,23], 签到历史，集合，一个月中的哪一天 */
@property (nonatomic, strong) NSArray *signTimes;

@end
