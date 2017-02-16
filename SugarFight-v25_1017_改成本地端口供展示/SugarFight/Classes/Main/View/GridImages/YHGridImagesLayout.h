//
//  YHGridImagesLayout.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHGridImagesLayout;

/**
 static CGFloat const YHMarginOfCollectionViewColumn = 10;
 static CGFloat const YHHeaderViewHeightOfCollectionView = 20;
 static NSInteger const YHNumberOfCollumns = 2;
 static NSInteger const YHNumberOfSectionsOfGridImages = 3;
 */

@protocol YHGridImagesLayoutDelegate <NSObject>

@optional
///当前layout有多少列
- (NSInteger)numberOfColumnsOnGridImagesLayout:(YHGridImagesLayout *)layout;
///当前layout有多少组
- (NSInteger)numberOfSectionsOnGridImagesLayout:(YHGridImagesLayout *)layout;

///列之前的间距
- (CGFloat)marginBetweenCollectionViewColumnsOfGridImagesLayout:(YHGridImagesLayout *)layout;
///collectionView的组头的高度
- (CGFloat)headerViewHeightOfCollectionViewSectionOfGridImagesLayout:(YHGridImagesLayout *)layout;

@end

@interface YHGridImagesLayout : UICollectionViewFlowLayout

/** delegate */
@property (nonatomic, weak) id<YHGridImagesLayoutDelegate> delegate;
@end
