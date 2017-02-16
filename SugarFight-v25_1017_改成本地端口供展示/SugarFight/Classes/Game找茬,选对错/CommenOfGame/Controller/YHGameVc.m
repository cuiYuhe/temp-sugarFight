//
//  YHGameVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGameVc.h"


@interface YHGameVc ()

@end

@implementation YHGameVc
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSMutableArray<id<SDWebImageOperation>> *)imageOperations{
    if (!_imageOperations) {
        self.imageOperations = [[NSMutableArray alloc] init];
    }
    return _imageOperations;
}

- (NSMutableDictionary *)imagesDic{
    if (!_imagesDic) {
        self.imagesDic = [[NSMutableDictionary alloc] init];
    }
    return _imagesDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
    //取消下载图片的操作
    for (id imageOp in self.imageOperations) {
        [imageOp cancel];
    }
}

#pragma mark ------------------------------------------
#pragma mark public method,供子类调用
///设置imageViews数组的图片
- (void)setImagesWithImageViews:(NSArray *)imageViews stringUrls:(NSArray *)stringUrls completed:(void(^)())completed failed:(void(^)(NSError *error))failed{
    
    NSInteger count = stringUrls.count; //待下载总数
    __block NSInteger loadedImagesCount = 0; //已经下载数量
    for (NSInteger i = 0; i<count; i++) {
        [self setImageToImgView:stringUrls[i] imageViewToSet:imageViews[i] success:^{
            loadedImagesCount++;
            YHLog(@"loaded = %zd", loadedImagesCount);
            if (loadedImagesCount == count) {
                !completed ? : completed();
            }
            
        } failed:^(NSError *error) {
            !failed ? : failed(error);
        }];
    }
}

///判断剩余赞的按钮是否隐藏
- (void)isHideLeftZanBtn:(UIButton *)leftZanBtn{
    
    YHUserType type = [GlobeSingle shareGlobeSingle].userType;
    if (type > YHUserTypeCommonNotWS) {
        leftZanBtn.hidden = YES;
        leftZanBtn = nil;
    }
}

#pragma mark ------------------------------------------
#pragma mark private method
///设置指定imageView的image
- (void)setImageToImgView:(NSString *)urlStr imageViewToSet:(YHPopAllScreenImageView *)imgV success:(void(^)())success failed:(void(^)(NSError *error))failed{
    
    imgV.image = nil;
    //1.先从自己保存的图片中取
    UIImage *savedImage = self.imagesDic[urlStr];
    if (savedImage) {
        imgV.image = savedImage;
        !success ? : success();
        return;
    }
    //2.如果没有保存图片,则下载
    NSURL *url = [NSURL URLWithString:urlStr];
    
    id imageOperation = [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        imgV.progress = progress;
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (image) {
                imgV.image = image;
                //3.保存图片
                self.imagesDic[urlStr] = image;
                success();

            }else{//没有加载出来图片,网址错误
                failed(error);
            }
        });
    }];
    
    if (imageOperation) {
        [self.imageOperations addObject:imageOperation];
    }else{
        YHLog(@"imgOperation = nil");
    }
}

@end
