//
//  YHMyRankingCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHMyRankingCell.h"
#import "UIImageView+Extension.h"
#import "YHSingleRankModel.h"

@interface YHMyRankingCell()
///头像
@property (weak, nonatomic) IBOutlet UIImageView *icon;
///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///分数
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
///称谓
@property (weak, nonatomic) IBOutlet UILabel *myAppellationLabel;
///名次
@property (weak, nonatomic) IBOutlet UIButton *rankingBtn;

@end

@implementation YHMyRankingCell
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat fontSize = 18.0f;
//    if (YHScreenW >= 375.0f) {//iphone6及以上的宽度
//        fontSize = 18.0f;
//    }
    self.rankingBtn.titleLabel.font = YHFontFZHuangCao(fontSize);
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 3;
    [super setFrame:frame];
}

- (void)setRankM:(YHSingleRankModel *)rankM{
    _rankM = rankM;
    [self.icon yh_setImageWithURLString:rankM.userAvatar imageName:@"placeholder_b"];
    self.nameLabel.text = rankM.userName;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", rankM.userScore.floatValue];
    self.myAppellationLabel.text = rankM.userLevel;
    
    NSNumber *rank = nil;
    switch (self.selectedLevelType) {
        case YHRankLevelTypeArea:
            rank = rankM.aRank;
            break;
        case YHRankLevelTypeCity:
            rank = rankM.cRank;
            break;
        case YHRankLevelTypeProvince:
            rank = rankM.pRank;
            break;
            
        default:
            break;
    }
    [self.rankingBtn setNormalTitle:[NSString stringWithFormat:@"第%@名", rank]];
}

@end
