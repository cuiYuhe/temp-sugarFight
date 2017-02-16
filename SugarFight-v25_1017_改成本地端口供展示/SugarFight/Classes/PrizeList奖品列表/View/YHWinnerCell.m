//
//  YHWinnerCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHWinnerCell.h"
#import "YHWinnerSingleM.h"

@interface YHWinnerCell()
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

@end

@implementation YHWinnerCell

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
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setWinnerSingleM:(YHWinnerSingleM *)winnerSingleM{
    _winnerSingleM = winnerSingleM;
    self.winnerLabel.text = [NSString stringWithFormat:@"%@ %@ %@", winnerSingleM.successUser, winnerSingleM.gift, winnerSingleM.successTime];
}

@end
