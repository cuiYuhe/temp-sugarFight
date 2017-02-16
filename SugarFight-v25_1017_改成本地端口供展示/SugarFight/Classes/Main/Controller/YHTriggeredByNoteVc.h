//
//  YHTriggeredByNoteVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
#import "YHPushModel.h"

@interface YHTriggeredByNoteVc : YHViewController


/****************************** 通知相关属性 --- begin  **************************/
/** YHPushModel,远程通知给的信息 */
@property (nonatomic, strong) YHPushModel *pushM;
/** 收到通知时,如果在当前界面,需不需要重新加载通知 */
@property (nonatomic, assign, getter=isReloadNetworkData) BOOL reloadNetworkData;


/****************************** 通知相关属性 --- end  **************************/


@end
