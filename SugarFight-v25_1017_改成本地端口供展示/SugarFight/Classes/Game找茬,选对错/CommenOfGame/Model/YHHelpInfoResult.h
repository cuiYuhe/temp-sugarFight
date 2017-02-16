//
//  YHHelpInfoResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHHelpInfoMsgModel.h"

@interface YHHelpInfoResult : YHBaseModel
/** YHHelpInfoMsgModel array */
@property (nonatomic, strong) NSArray<YHHelpInfoMsgModel *> *helpMsgs;
@end
