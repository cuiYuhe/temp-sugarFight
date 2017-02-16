//
//  YHUploadActvtyCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/9.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGridImagesCell.h"
#import "YHPopAllScreenImageView.h"

static CGFloat YHMarginRateOfTop = 24.0/284;
static CGFloat YHMarginRateOfLeft = 16.0/288;
static CGFloat YHMarginRateOfBottom = 30.0/284;
static CGFloat YHMarginRateOfRight = 20.0/288;

@interface YHGridImagesCell()
/** bgImgView */
@property (nonatomic, weak) UIImageView *bgImgView;

@end

@implementation YHGridImagesCell

- (void)awakeFromNib{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //不接收点击事件 1.不拦截cell的点击事件 2.不pop出来全屏的图片
    self.bgImgView.frame = self.bounds;
    self.picImgView.frame = [self getFrameOfPicImageView];
    self.picImgView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark ------------------------------------------
#pragma mark 子类调用的方法
- (void)setup{
    //1.背景图片
    UIImageView *bgImgView = [[UIImageView alloc] init];
    bgImgView.image = [UIImage imageNamed:@"upload_bg_kuang"];
    self.bgImgView = bgImgView;
    [self.contentView addSubview:bgImgView];
    
    //2.显示图片的imageView
    self.picImgView.contentMode = UIViewContentModeScaleAspectFit;
}


+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (CGRect)getFrameOfPicImageView{
    CGFloat picImgViewX = self.yh_width * YHMarginRateOfLeft;
    CGFloat picImgViewY = self.yh_height * YHMarginRateOfTop;
    CGFloat picImgViewW = self.yh_width * (1 - YHMarginRateOfLeft - YHMarginRateOfRight);
    CGFloat picImgViewH = self.yh_height * (1 - YHMarginRateOfTop - YHMarginRateOfBottom);
    CGRect rect = CGRectMake(picImgViewX, picImgViewY, picImgViewW, picImgViewH);
    return rect;
}


- (void)setImageToShow:(UIImage *)imageToShow{
    _imageToShow = imageToShow;
    self.picImgView.image = imageToShow;

}

@end
