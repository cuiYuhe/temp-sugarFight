//
//  YHStudyInsidePPTCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHStudyInsidePPTCell;

@protocol YHStudyInsidePPTCellDelegate <NSObject>

@optional
- (void)studyInsidePPTCell:(YHStudyInsidePPTCell *)cell DidFinishDownloadImage:(UIImage *)image imageUrl:(NSString *)stringUrl;

@end

@interface YHStudyInsidePPTCell : UICollectionViewCell
/** 切换cell时赋值,即每次显示cell时.如果有模型,可以放在模型中 */
@property (nonatomic, assign, getter=isShiftCell) BOOL shiftCell;
/** string url */
@property (nonatomic, strong) NSString *stringUrl;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
/** delegate */
@property (nonatomic, weak) id<YHStudyInsidePPTCellDelegate> delegate;

+ (NSString *)identifier;
@end
