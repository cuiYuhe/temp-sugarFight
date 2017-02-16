//
//  YHStudyInsidePPTCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHStudyInsidePPTCell.h"
#import "YHLabeledCircularProgressView.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageDownloaderOperation.h>
#import "YHDownloadImageView.h"

@interface YHStudyInsidePPTCell()<UIScrollViewDelegate>
/** 题目图片加在此scrollView中 */
@property (nonatomic, weak) UIScrollView *scrollView;
@property (weak, nonatomic) YHDownloadImageView *exerciseImageView;
/** YHLabeledCircularProgressView */
@property (nonatomic, weak) YHLabeledCircularProgressView *progressView;
/** images字典: url : image */
@property (nonatomic, strong) NSMutableDictionary *imagesDic;
/** exerciseImageView 上次的形变 */
@property (nonatomic, assign) CGFloat lastScaleChange;
@end

@implementation YHStudyInsidePPTCell
- (NSMutableDictionary *)imagesDic{
    if (!_imagesDic) {
        self.imagesDic = [NSMutableDictionary dictionary];
    }
    return _imagesDic;
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
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    [self.contentView addSubview:sc];
    sc.maximumZoomScale = 3.0;
    sc.minimumZoomScale = 0.8;
    sc.delegate = self;
    sc.frame = self.contentView.bounds;
    self.scrollView = sc;
    
    YHDownloadImageView *exerciseImageView = [[YHDownloadImageView alloc] init];
    self.exerciseImageView = exerciseImageView;
    exerciseImageView.backgroundColor = [UIColor blackColor];
    exerciseImageView.contentMode = UIViewContentModeScaleAspectFit;
    exerciseImageView.layer.borderWidth = 3;
    exerciseImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    exerciseImageView.userInteractionEnabled = YES;
    //添加双击变大手势
    UITapGestureRecognizer *tapDoubleGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDouble:)];
    tapDoubleGes.numberOfTapsRequired = 2;
    [exerciseImageView addGestureRecognizer:tapDoubleGes];
    
    exerciseImageView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:exerciseImageView];
    
    //progress view
    YHLabeledCircularProgressView *progressView = [[YHLabeledCircularProgressView alloc] init];
    self.progressView = progressView;
    progressView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:progressView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.progressView.yh_size = CGSizeMake(100, 100);
    self.progressView.center = self.contentView.center;
    
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

- (void)setStringUrl:(NSString *)stringUrl{
    
    _stringUrl = [stringUrl copy];
    
    YHLog(@"strUrl = %@", stringUrl);
    
    //1.1 清空循环引用的img
    self.exerciseImageView.image = nil;
    
    //1.2 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:self.pictureProgress animated:NO];
    
    //1.先从自己保存的图片中取
    UIImage *savedImage = self.imagesDic[stringUrl];
    if (savedImage) {
        self.exerciseImageView.image = savedImage;
        
        if ([self.delegate respondsToSelector:@selector(studyInsidePPTCell:DidFinishDownloadImage:imageUrl:)]) {
            [self.delegate studyInsidePPTCell:self DidFinishDownloadImage:savedImage imageUrl:stringUrl];
        }
        return;
    }
    
    //2.如果没有保存图片,则下载
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:stringUrl] options:SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:NO];
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        if (image) {//获得图片成功
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                self.exerciseImageView.image = image;
                
                //保存图片
                self.imagesDic[stringUrl] = image;
                if ([self.delegate respondsToSelector:@selector(studyInsidePPTCell:DidFinishDownloadImage:imageUrl:)]) {
                    [self.delegate studyInsidePPTCell:self DidFinishDownloadImage:savedImage imageUrl:stringUrl];
                }
            });
            [YHHttpTool informServerDownloadImgSuccess];
            
        }else{//获得图片失败
            [MBProgressHUD showError:@"请检查网络,稍后重试."];
            YHLog(@"error = %@", error);
        }
    }];
}

#pragma mark ------------------------------------------
#pragma mark 事件
- (void)tapDouble:(UITapGestureRecognizer *)tapGes{
    
    float newscale=1.8;
    
    CGRect zoomRect = [self zoomRectForScale:newscale withCenter:[tapGes locationInView:tapGes.view]];
    
//    [ self.scrollView zoomToRect:zoomRect animated:YES];//重新定义其cgrect的x和y值
    //    [_scrollView setZoomScale:newscale animated:YES];//以原先中心为点向外扩
    
    if (self.scrollView.zoomScale == newscale) {
        self.lastScaleChange = 1.0;
        [self.scrollView setZoomScale:self.lastScaleChange animated:YES];
    }else{
//        self.lastScaleChange = 1.0;
        [self.scrollView zoomToRect:zoomRect animated:YES];
    }
    
}

///http://blog.csdn.net/sinyran/article/details/8261776
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {//传入缩放比例和手势的点击的point返回<span style="color:#ff0000;">缩放</span>后的scrollview的大小和X、Y坐标点
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [_scrollView frame].size.height / scale;
    zoomRect.size.width  = [_scrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    //    zoomRect.origin.x=center.x;
    //    zoomRect.origin.y=center.y;
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

#pragma mark ------------------------------------------
#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.exerciseImageView;
}

@end
