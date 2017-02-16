//
//  YHCommonUploadPicVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommonUploadPicVc.h"
#import "YHAlertController.h"
#import "NSArray+Extension.h"

static CGFloat YHMarginToBottom = 80;

@interface YHCommonUploadPicVc ()<YHAlbumToolDelegate>
/** progressView */
//@property (nonatomic, weak) YHProgressRectangleView *progressView;
@end

@implementation YHCommonUploadPicVc
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSMutableArray<UIImage *> *)pickedImages{
    if (!_pickedImages) {
        self.pickedImages = [[NSMutableArray alloc] init];
    }
    return _pickedImages;
}

#pragma mark ------------------------------------------
#pragma mark 子类实现的方法

#pragma mark ------------------------------------------
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup{
    YHAlbumTool *album = [YHAlbumTool shareAlbumTool];
    album.delegate = self;
    
    //添加progressView
    YHProgressRectangleView *progressView = [[YHProgressRectangleView alloc] init];
    CGFloat progressViewW = 100;
    CGFloat progressViewH = 20;
    CGFloat progressViewX = (self.view.yh_width - progressViewW)/2;
    CGFloat progressViewY = self.view.yh_height - progressViewH - YHMarginToBottom;
    progressView.frame = CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH);
    progressView.hidden = YES;
    [self.view addSubview:progressView];
    self.progressViewOfUpload = progressView;
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadOnePicSucceed:) name:YHUploadOnePicSucessNotification object:nil];
    
}

- (void)showAlertVcWithMessage:(NSString *)message{
    YHAlertController *alertVc = [YHAlertController alertWithTitle:@"提示" message:message singleActionTitle:@"确定"];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (BOOL)isSameImagesInImages:(NSMutableArray *)images{
    
    //1.判断选择的图片是否重复
    NSMutableArray<NSString *> *md5s = [NSMutableArray array];
    for (UIImage *img in images) {
        NSString *md5 = [img yh_md5HashFromUIImage];
        [md5s addObject:md5];
    }
    
    NSInteger count = md5s.count;
    for (NSInteger index=0; index<count; index++){
        for (NSInteger i=0; i<count; i++){
            NSString *md5 = md5s[index];
            if (i != index) {
//                YHLog(@"md = %@", md5);
//                YHLog(@"md5s[i] = %@", md5s[index]);
                if ([md5s[i] isEqualToString:md5]) {//有相同
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

///根据传入的imageViews数组得到图片数组
- (NSMutableArray<UIImage *> *)getImagesWithImageViews:(NSArray *)imageViews{
    NSMutableArray *images = [NSMutableArray array];
    for (UIImageView *iv in imageViews) {
        if (iv.image) {
            [images addObject:iv.image];
        }
    }
    return images;
}

///得到图片的md5,并转变成上传时的md5参数
- (NSString *)getMd5ParamOfUploadWithImages:(NSArray *)images{
    
    NSMutableArray *strings = [NSMutableArray array];
    
    for (UIImage *image in images) {
        NSString *str = [image yh_md5HashFromUIImage];
        [strings addObject:str];
    }
    return [strings stringWithStringArray];
}

///上传图片到oss
- (void)uploadPicToOssWithImagesToUpload:(NSArray *)imagesToUpload saveImageFolder:(NSString *)folderName uploadError:(void(^)(NSError * error, NSArray *imageOSSPaths))uploadError{
    //2.在OSS上面的图片名称
    NSMutableArray *imageNamesOSS = [NSMutableArray array];
    //3.图片在OSS相对路径
    NSMutableArray *imageOSSPaths = [NSMutableArray array];
    
    for (NSInteger count = imagesToUpload.count, i = 0; i < count; i++) {
        
        //图片名称:年月日_时间戳_uuid
        //年月日
        NSString *dateString = [[YHDateTool shareDateTool] getDateStringWithFullDateFormat:@"yyyy-MM-dd_HH:mm:ss" date:[NSDate date]];
        //时间戳
        NSString *timeString = [NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]];
        NSString *imageName = [NSString stringWithFormat:@"%@/%@_%@_%@.jpg", folderName, dateString, [GlobeSingle shareGlobeSingle].uuid, timeString];
#if DEBUG
        imageName = [NSString stringWithFormat:@"testByCui/%@_%@_%@.jpg", dateString, [GlobeSingle shareGlobeSingle].uuid, timeString];
        imageName = [NSString stringWithFormat:@"testByCui/%@_%zd%zd%zd-%zd%zd%zd.jpg",timeString,i,i,i,i,i,i];
#endif
        //1.在OSS上面的图片名称
        [imageNamesOSS addObject:imageName];
        
        //2.图片的绝对路径,上传服务器时使用. 如:per/94335793258390385475.jpg
        NSString *imagePath = [YHOSSEndPoint stringByAppendingString:imageName];
        [imageOSSPaths addObject:imagePath];
    }

    //上传到OSS
    [[YHImageManager shareImageManager] uploadToOSS:imagesToUpload imageNames:imageNamesOSS uploadError:^(NSError *error) {
        uploadError(error, imageOSSPaths);
    }];
}

#pragma mark ------------------------------------------
#pragma mark observer
- (void)uploadOnePicSucceed:(NSNotification *)note{
    
    NSNumber *count = note.userInfo[YHUploadOnePicSucessNotificationKey];
    NSInteger uploadedPicCount = count.integerValue;
    NSInteger totalUploadNeed = self.pickedImages.count;
    CGFloat progress = 1.0 * uploadedPicCount / totalUploadNeed;
    self.progressViewOfUpload.progress = progress;
    
}

@end
