//
//  YHThreeDataCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHThreeDataCell.h"
#import "YHDistrictFocusCell.h"

static NSString *const ID = @"cell";

@interface YHThreeDataCell()


/** 省份或百分率 */
@property (nonatomic, weak) UILabel *midLabel;
/** 数值,可能有背景图片 */
@property (nonatomic, weak) UIButton *rightBtn;

@end

@implementation YHThreeDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:leftLabel];
        self.leftLabel = leftLabel;
        
        UILabel *midLabel = [[UILabel alloc] init];
        midLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:midLabel];
        midLabel.textColor = [UIColor whiteColor];
        self.midLabel = midLabel;
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.contentMode = UIViewContentModeCenter;
        [rightBtn setNormalTitleColor:[UIColor whiteColor]];
        [self.contentView addSubview:rightBtn];
        self.rightBtn = rightBtn;
        self.rightBtn.enabled = NO;
        
        self.contentView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat width = self.contentView.yh_width;
    CGFloat height = self.contentView.yh_height;
    
    CGFloat leftX = 2;
    CGFloat leftY = 0;
    CGFloat leftW = width / 3 - leftX;
    CGFloat leftH = height;
    self.leftLabel.frame = CGRectMake(leftX, leftY, leftW, leftH);
    
    CGFloat midX = CGRectGetMaxX(self.leftLabel.frame);
    CGFloat midY = 0;
    CGFloat midW = width / 3;
    CGFloat midH = height;
    self.midLabel.frame = CGRectMake(midX, midY, midW, midH);
    
    NSDictionary *attrs = @{NSFontAttributeName : self.rightBtn.titleLabel.font};
    CGSize btnSize = [self.rightBtn.titleLabel.text sizeWithAttributes:attrs];
    CGFloat btnH = btnSize.height + 5;
    
    //为了背景的椭圆的展示,加15的余量;如果+15后,大于给当前btn预留的最大宽度,则用预留的最大宽度
    CGFloat targetW = btnSize.width + 15;
    targetW = width/3 > targetW ? targetW : width/3;
    CGFloat btnW = targetW;
    CGFloat btnX = CGRectGetMaxX(self.midLabel.frame) + (width / 3 - btnW ) / 2;
    CGFloat btnY = (self.contentView.yh_height - btnH) / 2;
    self.rightBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

+ (NSString *)identifier{
    return @"YHThreeDataCell";
}

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setHeightToDecrease:(CGFloat)heightToDecrease{
    _heightToDecrease = heightToDecrease;
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= self.heightToDecrease;
    [super setFrame:frame];
}

- (void)setModel:(YHThreeDataCellModel *)model{
    _model = model;
    self.leftLabel.text = model.leftData;
    self.midLabel.text = model.midData;
    [self.rightBtn setNormalTitle:model.rightData];
}

- (void)setLeftDataColor:(UIColor *)leftDataColor{
    _leftDataColor = leftDataColor;
    self.leftLabel.textColor = leftDataColor;
}

- (void)setLeftBold:(BOOL)leftBold{
    _leftBold = leftBold;
    CGFloat fontSize = self.leftLabel.font.pointSize;
    self.leftLabel.font = [UIFont boldSystemFontOfSize:fontSize];
}

+ (YHThreeDataCell *)cellWithTableView:(UITableView *)tableView WithFontOfLeftData:(CGFloat)leftFont fontOfMidData:(CGFloat)midFont fontOfRightData:(CGFloat)rightFont isBgOfRightData:(BOOL)isBgOfRight{

    YHThreeDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (leftFont) {
        cell.leftLabel.font = [UIFont systemFontOfSize:leftFont];
    }
    if (midFont) {
        cell.midLabel.font = [UIFont systemFontOfSize:midFont];
    }
    if (rightFont) {
        cell.rightBtn.titleLabel.font = [UIFont systemFontOfSize:rightFont];
    }
    
    if (isBgOfRight) {
        [cell.rightBtn setNormalBackgroundImage:@"bg_rank_num"];
    }else{
        [cell.rightBtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    return cell;
    
}
@end
