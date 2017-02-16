//
//  YHGiftSuccessView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHGiftSuccessView, YHPrizeSubReceiverModel;

@protocol YHGiftSuccessViewDelegate <NSObject>

@optional
/**
 *  点击了'修改'按钮
 */
- (void)giftSuccessViewDidClickModify:(YHGiftSuccessView *)sucView;

/**
 *  点击了'确认'按钮
 */
- (void)giftSuccessViewDidClickCfm:(YHGiftSuccessView *)sucView;

@end

@interface YHGiftSuccessView : UIView
/** delegate */
@property (nonatomic, weak) id<YHGiftSuccessViewDelegate> delegate;

/** YHPrizeSubReceiverModel */
@property (nonatomic, strong) YHPrizeSubReceiverModel *receiver;

@end
