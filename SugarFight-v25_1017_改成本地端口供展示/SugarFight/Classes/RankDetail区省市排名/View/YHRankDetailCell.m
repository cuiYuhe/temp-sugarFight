//
//  YHRankDetailCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHRankDetailCell.h"
#import "YHSingleRankModel.h"
#import "UIImageView+Extension.h"

@interface YHRankDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
///昵称
@property (weak, nonatomic) IBOutlet UILabel *appellationLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@end

@implementation YHRankDetailCell

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
    
    CGFloat fontSize = 16;
    
    self.cityRankLabel.font = YHFontFZHuangCao(fontSize);
    self.provinceRankLabel.font = YHFontFZHuangCao(fontSize);
    self.districtRankLabel.font = YHFontFZHuangCao(fontSize);
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 3;
    [super setFrame:frame];
}

#pragma mark ------------------------------------------
#pragma mark external method
+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (void)setRankM:(YHSingleRankModel *)rankM{
    _rankM = rankM;
    [self.iconImgView yh_setImageWithURLString:rankM.userAvatar imageName:@"placeholder_b"];
    self.nameLabel.text = rankM.userName;
    self.cityRankLabel.text = [NSString stringWithFormat:@"第%@名", rankM.cRank];
    self.provinceRankLabel.text = [NSString stringWithFormat:@"第%@名", rankM.pRank];
    self.districtRankLabel.text = [NSString stringWithFormat:@"第%@名", rankM.aRank];
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", rankM.userScore.floatValue];
    self.appellationLabel.text = rankM.userLevel;
    self.placeLabel.text = rankM.province;
    
}


@end
