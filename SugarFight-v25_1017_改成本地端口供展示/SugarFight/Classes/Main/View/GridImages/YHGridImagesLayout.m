//
//  YHGridImagesLayout.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGridImagesLayout.h"

static CGFloat const YHMarginOfCollectionViewColumn = 10;
static CGFloat const YHHeaderViewHeightOfCollectionView = 30;

@implementation YHGridImagesLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    NSInteger numberOfCollumns = [self getNumberOfColumns];
    NSInteger numberOfSections = [self getNumberOfSections];
    CGFloat marginBetweenColumns = [self getMarginBetweenCollectionViewColumns];
    CGFloat headerViewHeightOfSection = [self getHeaderViewHeightOfSection];
    
    CGFloat w = (self.collectionView.frame.size.width - (numberOfCollumns - 1) * marginBetweenColumns) / numberOfCollumns;
    CGFloat h = (self.collectionView.frame.size.height) / numberOfSections - headerViewHeightOfSection;
    self.itemSize = CGSizeMake(w, h);
    self.headerReferenceSize = CGSizeMake(0, headerViewHeightOfSection);
    self.minimumInteritemSpacing = marginBetweenColumns;

}

#pragma mark ------------------------------------------
#pragma mark private method
///列数
- (NSInteger)getNumberOfColumns{
    if ([self.delegate respondsToSelector:@selector(numberOfColumnsOnGridImagesLayout:)]) {
        return [self.delegate numberOfColumnsOnGridImagesLayout:self];
    }else{
        return YHNumberOfColumnsInEachSectionOfGridImages;
    }
}

///组数
- (NSInteger)getNumberOfSections{
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsOnGridImagesLayout:)]) {
        return [self.delegate numberOfSectionsOnGridImagesLayout:self];
    }else{
        return YHNumberOfSectionsOfGridImages;
    }
}

///列之前间距
- (CGFloat)getMarginBetweenCollectionViewColumns{
    if ([self.delegate respondsToSelector:@selector(marginBetweenCollectionViewColumnsOfGridImagesLayout:)]) {
        return [self.delegate marginBetweenCollectionViewColumnsOfGridImagesLayout:self];
    }else{
        return YHMarginOfCollectionViewColumn;
    }
}

///组头的高度
- (CGFloat)getHeaderViewHeightOfSection{
    if ([self.delegate respondsToSelector:@selector(headerViewHeightOfCollectionViewSectionOfGridImagesLayout:)]) {
        return [self.delegate headerViewHeightOfCollectionViewSectionOfGridImagesLayout:self];
    }else{
        return YHHeaderViewHeightOfCollectionView;
    }
}
@end
