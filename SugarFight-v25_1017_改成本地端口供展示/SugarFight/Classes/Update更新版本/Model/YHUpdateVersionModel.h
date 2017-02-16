//
//  YHUpdateVersionModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHUpdateMsgModel.h"

@interface YHUpdateVersionModel : YHBaseModel
/** YHUpdateMsgModel */
@property (nonatomic, strong) YHUpdateMsgModel *updateMsg;
@end
