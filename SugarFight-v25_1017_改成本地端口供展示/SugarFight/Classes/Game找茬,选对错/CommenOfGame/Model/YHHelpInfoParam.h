//
//  YHHelpInfoParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHelpInfoParam : NSObject

/** uid	Integer	请求帮助信息的用户id	1 */
@property (nonatomic, strong) NSNumber *uid;
/** Integer	请求的帮助信息的类型	1:笑傲江湖帮助信息; 0:完美门店帮助信息  */
@property (nonatomic, assign) NSInteger category;

@end
