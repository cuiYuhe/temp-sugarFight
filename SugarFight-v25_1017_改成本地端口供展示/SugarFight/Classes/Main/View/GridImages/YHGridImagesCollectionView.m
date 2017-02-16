//
//  YHGridImagesCollectionView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGridImagesCollectionView.h"
#import "YHGridImagesCell.h"
#import "YHGridImagesHeaderView.h"
#import "YHGridImagesLayout.h"

@implementation YHGridImagesCollectionView

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
    YHGridImagesLayout *layout = [[YHGridImagesLayout alloc] init];
    self.collectionViewLayout = layout;
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([YHGridImagesHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[YHGridImagesHeaderView identifier]];
}



@end
