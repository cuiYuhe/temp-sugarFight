//
//  YHGetDistrictsResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHHeadDistrictMsgModel.h"

@interface YHHeadDistrictsResult : YHBaseModel

/** areaMsgs 区域信息 */
@property (nonatomic, strong) NSArray *areaMsgs;
@end
