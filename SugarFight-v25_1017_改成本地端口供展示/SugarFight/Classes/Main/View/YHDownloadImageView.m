//
//  YHDownloadImageView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDownloadImageView.h"
#import "YHLabeledCircularProgressView.h"
#import "SDWebImageDownloader.h"

@interface YHDownloadImageView()
/** YHLabeledCircularProgressView */
@property (nonatomic, weak) YHLabeledCircularProgressView *progressView;

/** 用来取消下载图片的操作 */
@property (nonatomic, strong) NSMutableArray<id <SDWebImageOperation>> *imageOperations;

@end

@implementation YHDownloadImageView
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSMutableArray<id<SDWebImageOperation>> *)imageOperations{
    if (!_imageOperations) {
        self.imageOperations = [[NSMutableArray alloc] init];
    }
    return _imageOperations;
}

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
    
    //进度条
    YHLabeledCircularProgressView *progressView = [[YHLabeledCircularProgressView alloc] init];
    progressView.progressLabel.textColor = [UIColor orangeColor];
    progressView.progressLabel.font = [UIFont systemFontOfSize:15];
    self.progressView = progressView;
    self.progressView.hidden = YES;
    [self addSubview:progressView];
    self.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat WH = MIN(self.yh_width, self.yh_height) * 0.5;
    CGFloat progViewW = WH > 50.0f ? 50.0f : WH;
    CGFloat progViewH = progViewW;
    CGFloat progViewX = (self.yh_width - progViewW) * 0.5;
    CGFloat progViewY = (self.yh_height - progViewH) * 0.5;
    self.progressView.frame = CGRectMake(progViewX, progViewY, progViewW, progViewH);
}

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.progressView.hidden = NO;
    [self.progressView setProgress:progress animated:NO];
    
//        YHLog(@"progress = %f", progress);
    if (progress == 1.0f) {
        self.progressView.hidden = YES;
    }
}

- (void)setHiddenProgressView:(BOOL)hiddenProgressView{
    _hiddenProgressView = hiddenProgressView;
    self.progressView.hidden = YES;
}

- (void)yh_setImageWithUrl:(NSString *)stringUrl completed:(void(^)(UIImage *image, NSError *error))completed{
    self.image = nil;
    
    __block UIImage *downloadImage = nil;
    //2.如果没有保存图片,则下载
    NSURL *url = [NSURL URLWithString:stringUrl];
    
    id imageOperation = [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progress = progress;
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.image = image;
                downloadImage = image;
            });
            [YHHttpTool informServerDownloadImgSuccess];
        }
        completed(image, error);
    }];
    
    if (imageOperation) {
        [self.imageOperations addObject:imageOperation];
    }
}

- (void)stopDownLoadImage{
    //取消当前的下载图片操作
    for (id imageOp in self.imageOperations) {
        [imageOp cancel];
    }
}

@end
