//
//  YHGiftSuccessView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGiftSuccessView.h"
#import "YHPrizeSubReceiverModel.h"

@interface YHGiftSuccessView()
/** 礼品 */
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 电话 */
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end

@implementation YHGiftSuccessView


#pragma mark ------------------------------------------
#pragma mark set
- (void)setReceiver:(YHPrizeSubReceiverModel *)receiver{
    _receiver = receiver;
    self.giftLabel.text = [NSString stringWithFormat:@"摇到 %@ 产品", receiver.giftName];
    self.nameLabel.text = [NSString stringWithFormat:@"领奖人姓名: %@", receiver.name];
    self.telLabel.text = [NSString stringWithFormat:@"电话: %@", receiver.tel];
    self.addressLabel.text = [NSString stringWithFormat:@"地址: %@", receiver.address];
}


#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)modifyAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(giftSuccessViewDidClickModify:)]) {
        [self.delegate giftSuccessViewDidClickModify:self];
    }
}

- (IBAction)cfmAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(giftSuccessViewDidClickCfm:)]) {
        [self.delegate giftSuccessViewDidClickCfm:self];
    }
}

@end
