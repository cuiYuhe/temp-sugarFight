//
//  YHUploadPicActvtyCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHUploadPicActvtyCell.h"



@interface YHUploadPicActvtyCell()
/** 加号标志 imageView */
@property (nonatomic, weak) UIImageView *addImgView;

@end

@implementation YHUploadPicActvtyCell

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
    [super setup];
    
    //1.'+'图片
    UIImageView *addImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bt_add"]];
    self.addImgView = addImgV;
    [self.contentView addSubview:addImgV];
    
    //2.显示图片的imageView
    UIImageView *picImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:picImgView];
    self.picImgView = picImgView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.addImgView.center = CGPointMake(self.yh_width * 0.5, self.yh_height * 0.5);
}

@end
