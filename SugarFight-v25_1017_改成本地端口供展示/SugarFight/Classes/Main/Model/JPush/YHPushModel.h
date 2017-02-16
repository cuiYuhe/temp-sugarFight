//
//  YHPushModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/1.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHPushSubApsModel.h"
#import "YHPushSubPINGModel.h"
#import "YHPushSubZanModel.h"
#import "YHPushSubMsgModel.h"

@interface YHPushModel : NSObject

/** YHPushSubApsModel class */
@property (nonatomic, strong) YHPushSubApsModel *aps;


/** _j_msgid:1185165326, */
@property (nonatomic, strong) NSNumber *_j_msgid;
/** PING dic,请求的参数 */
@property (nonatomic, strong) YHPushSubPINGModel *PING;
//PING:{"imgUrl":"http://img.icgear.net/per/2016-07-29_09:26:15_65634f6b-5526-11e6-9ac6-02004c4f4f50_1469755575761.jpg","imgId":"113206","category":"2","imgTime":"20160729"}


/** YHPushSubZanModel */
@property (nonatomic, strong) YHPushSubZanModel *ZAN;
/** YHPushSubAlertModel */
@property (nonatomic, strong) YHPushSubMsgModel *MSG;
@end
