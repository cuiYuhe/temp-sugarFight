//
//  YHPrizeOwnerInfoVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
@class YHPrizeOwnerInfoVc, YHPrizeSubReceiverModel;

@protocol YHPrizeOwnerInfoVcDelegate <NSObject>

@optional

/**
 *  成功提交领奖人信息后,通知代理
 *  @param address  用户输入的地址
 */
- (void)prizeOwnerInfoVcDidSubmitPrizeInfo:(YHPrizeOwnerInfoVc *)prizeOwnerInfoVc prizeOwnerInfoM:(YHPrizeSubReceiverModel *)receiverM;

/**
 *  当前vc dismiss,而用户没有提交个人信息
 */
- (void)prizeOwnerInfoVcWillDismissWhileNoSubmitInfo:(YHPrizeOwnerInfoVc *)prizeOwnerInfoVc;

@end

@interface YHPrizeOwnerInfoVc : YHViewController

/** delegate */
@property (nonatomic, weak) id<YHPrizeOwnerInfoVcDelegate> delegate;
/** YHPrizeSubReceiverModel,如果有值,相关field初始时就用这个model的值 */
@property (nonatomic, strong) YHPrizeSubReceiverModel *receiverM;

@end
