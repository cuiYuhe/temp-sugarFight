//
//  YHShakePrizeResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHShakePrizeResult.h"

@implementation YHShakePrizeResult


- (void)setGift:(YHPrizeSubGiftModel *)gift{
    _gift = gift;
    _receiver.giftName = gift.name;
}

- (void)setReceiver:(YHPrizeSubReceiverModel *)receiver{
    _receiver = receiver;
    _receiver.giftName = _gift.name;
}
@end
