//
//  YHPrizeListCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPrizeListCell.h"
#import "YHPrizeSubGiftModel.h"

@interface YHPrizeListCell()

/** 添加事件,点击时,跳到抽奖 */
@property (weak, nonatomic) IBOutlet UIView *drawView;
/** 花费积分量 */
@property (weak, nonatomic) IBOutlet UILabel *drawCostLabel;
/** 中奖率 */
@property (weak, nonatomic) IBOutlet UILabel *winRateLabel;
/** 剩余抽奖次数 */
@property (weak, nonatomic) IBOutlet UILabel *leftCountLabel;
/** 礼品名称 */
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel;


@end

@implementation YHPrizeListCell

- (void)awakeFromNib{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawTap:)];
    [self.drawView addGestureRecognizer:tapGes];
}

#pragma mark ------------------------------------------
#pragma mark 手势
- (void)drawTap:(UITapGestureRecognizer *)tapGes{
    if ([self.delegate respondsToSelector:@selector(prizeListCellDidClickDraw:)]) {
        [self.delegate prizeListCellDidClickDraw:self];
    }
}

#pragma mark ------------------------------------------
#pragma mark 重写set
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setGiftM:(YHPrizeSubGiftModel *)giftM{
    _giftM = giftM;
    self.prizeLabel.text = giftM.name;
    self.winRateLabel.text = [NSString stringWithFormat:@"中奖率%.2f%%", giftM.probability.floatValue * 100];
    self.leftCountLabel.text = [NSString stringWithFormat:@"还剩%@", giftM.remain];
    self.drawCostLabel.text = [NSString stringWithFormat:@"需花费%.2f积分", giftM.costScore.floatValue];
    
}









@end
