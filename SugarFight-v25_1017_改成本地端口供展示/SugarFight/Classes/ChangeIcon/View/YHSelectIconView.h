//
//  YHSelectIconView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSelectIconView;
#import "YHAvasModel.h"

@protocol YHSelectIconViewDelegate <NSObject>

@optional
/**
 *  返回选择的头像信息
 *
 *  @param iconView 当前对象
 *  @param icon     选择的avatar
 *  @param index    选择的第几个avatar,从0开始.
 */
- (void)selectIconViewView:(YHSelectIconView *)iconView didSelectIcon:(UIImage *)icon iconIndex:(NSInteger)index;

@end

@interface YHSelectIconView : UIView

/** 显示的icons array */
@property (nonatomic, strong) NSArray<YHAvasModel *> *avas;
@property (nonatomic, weak) id<YHSelectIconViewDelegate> delegate;

@end
