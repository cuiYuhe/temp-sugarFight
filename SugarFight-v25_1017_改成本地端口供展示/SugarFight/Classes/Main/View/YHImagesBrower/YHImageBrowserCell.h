//
//  YHImageBrowserCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHDownloadImageView;

@interface YHImageBrowserCell : UICollectionViewCell

/** 切换cell时赋值,即每次显示cell时.如果有模型,可以放在模型中 */
@property (nonatomic, assign, getter=isShiftCell) BOOL shiftCell;
/** 图片 */
@property (nonatomic, weak) YHDownloadImageView *imageView;

+ (NSString *)identifier;
@end
