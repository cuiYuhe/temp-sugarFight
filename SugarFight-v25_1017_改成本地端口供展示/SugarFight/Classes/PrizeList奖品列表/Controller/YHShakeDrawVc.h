//
//  YHShaveDrawVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
@class YHShakeDrawVc, YHPrizeSubReceiverModel;

@protocol YHShakeDrawVcDelegate <NSObject>

@optional
- (void)shakeDrawVcDidChangePrizeOwnerInfo:(YHShakeDrawVc *)drawVc changedInfo:(YHPrizeSubReceiverModel *)receiverM;

@end

@interface YHShakeDrawVc : YHViewController

///摇奖的礼品ID,由前vc传入.摇奖时的参数之一
@property (nonatomic, strong) NSNumber *giftId;
/** delegate */
@property (nonatomic, weak) id<YHShakeDrawVcDelegate> delegate;

@end
