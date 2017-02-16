//
//  YHImageBrowserCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHImageBrowserCell.h"
#import "YHDownloadImageView.h"

@interface YHImageBrowserCell()<UIScrollViewDelegate>
/** 题目图片加在此scrollView中 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** exerciseImageView 上次的形变 */
@property (nonatomic, assign) CGFloat lastScaleChange;

@end

@implementation YHImageBrowserCell
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
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.contentView addSubview:sc];
    sc.maximumZoomScale = 3.0;
    sc.minimumZoomScale = 0.8;
    sc.delegate = self;
    sc.frame = self.contentView.bounds;
    self.scrollView = sc;
    
    YHDownloadImageView *iv = [[YHDownloadImageView alloc] init];
    [self.scrollView addSubview:iv];
    self.imageView = iv;
    iv.frame = self.scrollView.bounds;
    //添加双击变大手势
    iv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapDoubleGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDouble:)];
    tapDoubleGes.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tapDoubleGes];
    
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

#pragma mark ------------------------------------------
#pragma mark 重写set方法
- (void)setShiftCell:(BOOL)shiftCell{
    _shiftCell = shiftCell;
    if (self.isShiftCell) {
        [self.scrollView setZoomScale:1.0];
    }
}

#pragma mark ------------------------------------------
#pragma mark 事件
- (void)tapDouble:(UITapGestureRecognizer *)tapGes{
    
    if (self.lastScaleChange == 1.0) {
        self.lastScaleChange = 1.8;
    }else{
        self.lastScaleChange = 1.0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.scrollView setZoomScale:self.lastScaleChange];
    }];
}

#pragma mark ------------------------------------------
#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}



@end
