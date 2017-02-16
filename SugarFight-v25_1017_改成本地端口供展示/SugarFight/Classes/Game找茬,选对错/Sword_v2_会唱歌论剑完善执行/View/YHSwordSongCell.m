//
//  YHSwordSongCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSwordSongCell.h"
#import "YHPopAllScreenImageView.h"
#import "YHCustomSSImgModel.h"

@interface YHSwordSongCell()

@end

@implementation YHSwordSongCell

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
    //2.显示图片的imageView
    YHPopAllScreenImageView *picImgView = [[YHPopAllScreenImageView alloc] init];
    [self.contentView addSubview:picImgView];
    self.picImgView = picImgView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setImgM:(YHCustomSSImgModel *)imgM{
    _imgM = imgM;
//    YHLog(@"stringUrl = %@", imgM.imgUrl);
    YHPopAllScreenImageView *imgView = (YHPopAllScreenImageView *)self.picImgView;
    //如果有缓存图片
    if (imgM.imageCached) {
        imgView.image = imgM.imageCached;
        imgView.hiddenProgressView = YES;
        if ([self.delegate respondsToSelector:@selector(gridImagesCell:didFinishDownloadImage:imageStringUrl:)]) {
            [self.delegate gridImagesCell:self didFinishDownloadImage:imgM.imageCached imageStringUrl:imgM.imgUrl];
        }else{
            imgView.image = nil;
//            imgView.hiddenProgressView = YES;
        }
        return;
    }
    //没有缓存图片
    if (imgM.imgUrl) {
        
        [imgView yh_setImageWithUrl:imgM.imgUrl completed:^(UIImage *image, NSError *error) {
            
            if ([self.delegate respondsToSelector:@selector(gridImagesCell:didFinishDownloadImage:imageStringUrl:)]) {
                [self.delegate gridImagesCell:self didFinishDownloadImage:image imageStringUrl:imgM.imgUrl];
            }
        }];
    }else{
        imgView.image = nil;
        imgView.hiddenProgressView = YES;
        [imgView stopDownLoadImage];
    }
}

@end
