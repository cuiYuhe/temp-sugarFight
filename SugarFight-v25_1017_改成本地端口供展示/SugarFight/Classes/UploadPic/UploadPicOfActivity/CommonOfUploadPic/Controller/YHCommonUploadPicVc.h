//
//  YHCommonUploadPicVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
#import "YHHelpButton.h"
#import "YHHelpInfoParam.h"
#import "YHAlbumTool.h"
#import "UIImage+Extension.h"
#import "YHAlertController.h"

#import "YHUploadCheckModel.h"
#import "YHUploadPicParam.h"
#import "YHUploadPicResult.h"
#import "YHImageManager.h"
#import "YHDateTool.h"
#import "YHProgressRectangleView.h"

@interface YHCommonUploadPicVc : YHViewController

/** 选择的所有图片数组 */
@property (nonatomic, strong) NSMutableArray<UIImage *> *pickedImages;

/** 上传图片的进度 progressView */
@property (nonatomic, weak) YHProgressRectangleView *progressViewOfUpload;

///需要子类继承的方法
- (void)setup;

///弹出alertVc
- (void)showAlertVcWithMessage:(NSString *)message;

/**
 *  判断是否存在相同的图片
 *
 *  @param images 图片数组
 *
 *  @return 返回YES,表示有相同的图片
 */
- (BOOL)isSameImagesInImages:(NSMutableArray *)images;

/**
 *  根据传入的imageViews数组得到图片数组,有的imageView没有图片.供YHUploadPicPrideVC与YHUploadPicPerfectShopVC使用
 *
 *  @param imageViews imageViews数组
 *
 *  @return 返回图片数组
 */
- (NSMutableArray<UIImage *> *)getImagesWithImageViews:(NSArray *)imageViews;

/**
 *  得到图片的md5,并转变成上传时的md5参数
 *
 *  @param images 图片数组
 *
 *  @return 上传图片时的md5参数,如果是多张图片,md5是用,分隔
 */
- (NSString *)getMd5ParamOfUploadWithImages:(NSArray *)images;

/**
 *  上传图片到oss
 *
 *  @param imagesToUpload 需要上传的图片
 *  @param folderName     OSS上面保存图片的文件夹名称,如:per,Bcr
 *  @param uploadError    上传出现错误
 */
- (void)uploadPicToOssWithImagesToUpload:(NSArray *)imagesToUpload saveImageFolder:(NSString *)folderName uploadError:(void(^)(NSError * error, NSArray *imageOSSPaths))uploadError;

///成功上传一个图片的通知的方法,子类实现
- (void)uploadOnePicSucceed:(NSNotification *)note;
@end




