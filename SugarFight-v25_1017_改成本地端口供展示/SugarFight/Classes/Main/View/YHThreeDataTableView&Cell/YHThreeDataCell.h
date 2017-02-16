//
//  YHThreeDataCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHThreeDataCellModel.h"

@interface YHThreeDataCell : UITableViewCell
/** 姓名或省份  */
@property (nonatomic, weak) UILabel *leftLabel;

/** cell减少的高度 */
@property (nonatomic, assign) CGFloat heightToDecrease;

/** (233,232,206) */
@property (nonatomic, strong) UIColor *leftDataColor;
/** 左面数据是否是粗体 */
@property (nonatomic, assign, getter=isLeftBold) BOOL leftBold;

/** model */
@property (nonatomic, strong) YHThreeDataCellModel *model;

+ (NSString *)identifier;

+ (__kindof YHThreeDataCell *)cellWithTableView:(UITableView *)tableView WithFontOfLeftData:(CGFloat)leftFont fontOfMidData:(CGFloat)midFont fontOfRightData:(CGFloat)rightFont isBgOfRightData:(BOOL)isBgOfRight;
@end
