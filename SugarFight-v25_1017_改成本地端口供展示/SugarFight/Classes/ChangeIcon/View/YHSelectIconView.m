//
//  YHSelectIconView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSelectIconView.h"
#import <UIImageView+WebCache.h>

@interface YHIconCell: UICollectionViewCell

/** 背景框图片 */
@property (nonatomic, weak) UIImageView *bgBorderImgView;
/** icon imgView */
@property (nonatomic, weak) UIImageView *iconImgView;
/** YHAvasModel */
@property (nonatomic, strong) YHAvasModel *avatar;

@end

@implementation YHIconCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    UIImageView *bgImgV = [[UIImageView alloc] init];
    self.bgBorderImgView = bgImgV;
    bgImgV.image = [UIImage imageNamed:@"box-headimg"];
    [self.contentView addSubview:bgImgV];
    
    UIImageView *iconImgView = [[UIImageView alloc] init];
    self.iconImgView = iconImgView;
    [self.contentView addSubview:iconImgView];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 1;
    self.bgBorderImgView.frame = self.bounds;
    //2.iconImgView的frame
    CGFloat iconImgX = margin;
    CGFloat iconImgY = margin;
    CGFloat iconImgW = self.contentView.yh_width - 2 * margin;
    CGFloat iconImgH = self.contentView.yh_height - 2 * margin;
    self.iconImgView.frame = CGRectMake(iconImgX, iconImgY, iconImgW, iconImgH);
}

- (void)setAvatar:(YHAvasModel *)avatar{
    _avatar = avatar;
    NSURL *url = [NSURL URLWithString:self.avatar.refValue];
    [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ren"]];
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

@end

@interface YHIconFlowLayout : UICollectionViewFlowLayout

@end

@implementation YHIconFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    // 1.设置布局对象属性
    CGFloat itemH = self.collectionView.bounds.size.height; //目前是55
    CGFloat itemW = itemH;
    self.itemSize = CGSizeMake(itemW, itemH);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 2.设置collectionView对象属性
    //    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end

@interface YHIconCollectionView : UICollectionView

@end

@implementation YHIconCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    YHIconFlowLayout *myLayout = [[YHIconFlowLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:myLayout]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        [self registerClass:[YHIconCell class] forCellWithReuseIdentifier:[YHIconCell identifier]];
    }
    return self;
}

@end

@interface YHSelectIconView()<UICollectionViewDataSource, UICollectionViewDelegate>

/** YHIconCollectionView */
@property (nonatomic, weak) YHIconCollectionView *collectionView;

@end

@implementation YHSelectIconView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    
}

- (void)setup{
    
    YHIconCollectionView *clv = [[YHIconCollectionView alloc] init];
    [self addSubview:clv];
    self.collectionView = clv;
    clv.delegate = self;
    clv.dataSource = self;
}

- (void)setAvas:(NSArray<YHAvasModel *> *)avas{
    _avas = avas;
    [self.collectionView reloadData];
}

#pragma mark ------------------------------------------
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.avas.count;
}

- (YHIconCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHIconCell identifier] forIndexPath:indexPath];
    YHAvasModel *avar = self.avas[indexPath.row];
    cell.avatar = avar;
    
    return cell;
}

#pragma mark ------------------------------------------
#pragma mark UICollection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YHIconCell *cell = (YHIconCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSInteger index = indexPath.row;
    
    //将选择的日期传给代理
    if ([self.delegate respondsToSelector:@selector(selectIconViewView:didSelectIcon:iconIndex:)]) {
        [self.delegate selectIconViewView:self didSelectIcon:cell.iconImgView.image iconIndex:index];
    }
}

@end










