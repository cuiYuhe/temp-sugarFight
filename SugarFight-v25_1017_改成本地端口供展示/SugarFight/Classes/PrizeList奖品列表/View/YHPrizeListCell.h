//
//  YHPrizeListCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHTableViewCell.h"
@class YHPrizeListCell, YHPrizeSubGiftModel;

@protocol YHPrizeListCellDelegate <NSObject>

@optional

/**
 *  点击了cell上面的抽奖按钮
 */
- (void)prizeListCellDidClickDraw:(YHPrizeListCell *)cell;

@end

@interface YHPrizeListCell : YHTableViewCell


/** delegate */
@property (nonatomic, weak) id<YHPrizeListCellDelegate> delegate;
/** YHPrizeSubGiftModel */
@property (nonatomic, strong) YHPrizeSubGiftModel *giftM;

@end
