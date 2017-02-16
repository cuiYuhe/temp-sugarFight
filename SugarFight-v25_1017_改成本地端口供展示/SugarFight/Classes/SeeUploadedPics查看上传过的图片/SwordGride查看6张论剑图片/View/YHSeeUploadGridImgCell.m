//
//  YHSeeUploadGridImgCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/20.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSeeUploadGridImgCell.h"
#import "YHPopAllScreenImageView.h"
#import "SDWebImageDownloader.h"

@interface YHSeeUploadGridImgCell()


@end

@implementation YHSeeUploadGridImgCell

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

- (void)setImgUrl:(NSString *)imgUrl{
    
    if (!imgUrl) {//为空
        self.picImgView.image = nil;
        return;
    }
    _imgUrl = [imgUrl copy];
    [self setImageToImgView:imgUrl imageViewToSet:(YHPopAllScreenImageView *)self.picImgView];
}

- (void)setStopLoadImage:(BOOL)stopLoadImage{
    _stopLoadImage = stopLoadImage;
    YHPopAllScreenImageView *imgV = (YHPopAllScreenImageView *)self.picImgView;
    imgV.hiddenProgressView = YES;
    [imgV stopDownLoadImage];
}

///设置指定imageView的image
- (void)setImageToImgView:(NSString *)urlStr imageViewToSet:(YHPopAllScreenImageView *)imgV{
    
    //1.如果没有保存图片,则下载
    [imgV yh_setImageWithUrl:urlStr completed:^(UIImage *image, NSError *error) {
        if (image) {
            if ([self.delegate respondsToSelector:@selector(gridImagesCell:didFinishDownloadImage:imageStringUrl:)]) {
                [self.delegate gridImagesCell:self didFinishDownloadImage:image imageStringUrl:urlStr];
            }
        }
    }];
}

@end
