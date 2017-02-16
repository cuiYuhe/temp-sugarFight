//
//  YHProgressRectangleView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHProgressBorderView.h"
#import <UIKit/UIKit.h>

@interface YHProgressRectangleView : YHProgressBorderView
///** total待上传的数据大小,与actual配合使用 */
//@property (nonatomic, assign) CGFloat total;
///** 实际上传的数据大小, 与actual配合使用 */
//@property (nonatomic, assign) CGFloat actual;

/** 进度条的颜色 */
@property (nonatomic, strong) UIColor *progressColor;

/** 上传数据进度 */
@property (nonatomic, assign) CGFloat progress;

@end
