//
//  YHImagesBrower.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHImageBrowser.h"
#import "YHImageBrowserCell.h"

@interface YHImageBrowser()<UICollectionViewDataSource, UICollectionViewDelegate>
/** 图片轮播 */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YHImageBrowser
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
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[YHImageBrowserCell class] forCellWithReuseIdentifier:[YHImageBrowserCell identifier]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.collectionView.yh_width, self.collectionView.yh_height);
}

+ (YHImageBrowser *)imageBrowser{
    return [[self alloc] init];
}

#pragma mark ------------------------------------------
#pragma mark UICollectionView data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHImageBrowserCell identifier] forIndexPath:indexPath];
    cell.imageView = self.imageViews[indexPath.item];
    cell.shiftCell = YES;
    return cell;
}


@end
