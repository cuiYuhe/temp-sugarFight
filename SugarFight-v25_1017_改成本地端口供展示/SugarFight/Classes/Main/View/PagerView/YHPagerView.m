//
//  YHPagerView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPagerView.h"
#import "YHPagerCell.h"

@interface YHPagerLayout: UICollectionViewFlowLayout

@end

@implementation YHPagerLayout

- (void)prepareLayout{
    [super prepareLayout];
    // 1.设置布局对象属性
    CGFloat itemW = self.collectionView.bounds.size.width;
    CGFloat itemH = self.collectionView.bounds.size.height;
    self.itemSize = CGSizeMake(itemW, itemH);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 2.设置collectionView对象属性
    self.collectionView.pagingEnabled = YES;
//    self.collectionView.bounces = NO;
}
@end

@interface YHPagerView()<UICollectionViewDataSource, UICollectionViewDelegate>
/**  */
@property (nonatomic, weak) UICollectionView *collectionView;
@end


@implementation YHPagerView

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

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[YHPagerLayout alloc] init]];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[YHPagerCell class] forCellWithReuseIdentifier:[YHPagerCell identifier]];
}

- (void)setShowViews:(NSArray<UIView *> *)showViews{
    _showViews = showViews;

    if (showViews.count == 0) {
        [self removeFromSuperview];
    }
}


#pragma mark ------------------------------------------
#pragma mark UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.showViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YHPagerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHPagerCell identifier] forIndexPath:indexPath];
    cell.showView = self.showViews[indexPath.item];
    
    if (indexPath.item == self.showViews.count - 1) {
        
        
        if ([self.delegate respondsToSelector:@selector(pagerViewShouldHaveFinishBtnAtLastIndexPath:)]) {
            
            cell.finishBtn.hidden = NO;
            if (cell.finishBtn == nil) {//如果按钮还没有创建再创建
                
                cell.finishBtn = [self.delegate pagerViewShouldHaveFinishBtnAtLastIndexPath:self];
                
                [cell didClickFinishBtnWithTarget:self action:@selector(finishBtnClick)];
            }
        }
        
    }else{
        cell.finishBtn.hidden = YES;
    }
    
    return cell;
}

#pragma mark ------------------------------------------
#pragma mark UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setupAfterIdel];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView{
    [self setupAfterIdel];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (![self.delegate respondsToSelector:@selector(pagerViewDidFinishTurnOverAllPages:)]) {
        return;
    }
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat contentW = self.collectionView.contentSize.width;
    if (offsetX > contentW - self.collectionView.yh_width) {
        [self.delegate pagerViewDidFinishTurnOverAllPages:self];
    }
}

- (void)setupAfterIdel{
    NSInteger index = self.collectionView.contentOffset.x / self.collectionView.yh_width;
    if ([self.delegate respondsToSelector:@selector(pagerView:didTurnToPagerIndex:)]) {
        [self.delegate pagerView:self didTurnToPagerIndex:index];
    }
}

#pragma mark ------------------------------------------
#pragma mark event
- (void)finishBtnClick{
    if ([self.delegate respondsToSelector:@selector(pagerViewDidClickFinishBtn:)]) {
        [self.delegate pagerViewDidClickFinishBtn:self];
    }
}

@end
