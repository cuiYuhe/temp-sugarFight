//
//  YHGetDaysListResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetDaysListResult : NSObject

/**  days	此人上传过照片的日期，前面一个是角标（编号），后面一个是日期 */
@property (nonatomic, strong) NSArray *days;
/**  success	是否成功，成功true，失败false */
@property (nonatomic, strong) NSString *success;
/**  messages	返回信息 */
@property (nonatomic, strong) NSString *messages;

@end
