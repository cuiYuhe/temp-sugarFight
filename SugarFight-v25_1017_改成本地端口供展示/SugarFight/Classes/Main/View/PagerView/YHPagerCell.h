//
//  YHPagerCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHPagerCell : UICollectionViewCell

/** 最后界面按钮 */
@property (nonatomic, strong) UIButton *finishBtn;
/** 最后界面按钮的frame */
@property (nonatomic, assign) CGRect finishBtnFrame;
/** 呈放的view */
@property (nonatomic, weak) UIView *showView;

+ (NSString *)identifier;

///**
// *  设置最后页面的finishBtn
// *
// *  @param count     页面的总页数
// *  @param indexPath 当前的indexPath
// */
//- (void)setUpFinishBtnWithTotalItemsCount:(NSInteger)count currentIndexPath:(NSIndexPath *)indexPath;

/**
 *  最后页面的finishBtn的点击事件
 */
- (void)didClickFinishBtnWithTarget:(id)target action:(SEL)action;

@end
