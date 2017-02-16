//
//  YHHelpInfoMsgModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHHelpInfoMsgModel : NSObject

/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 序号 */
@property (nonatomic, assign) NSInteger sort;
/** title */
@property (nonatomic, copy) NSString *title;

@end
