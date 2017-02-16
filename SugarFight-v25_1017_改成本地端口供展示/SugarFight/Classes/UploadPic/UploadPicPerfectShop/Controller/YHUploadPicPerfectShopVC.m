//
//  YHUploadPicPerfectShopVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHUploadPicPerfectShopVC.h"
#import "NSArray+Extension.h"
#import "YHMd5CheckParam.h"


static NSString *const strUrlUploadOfPerfect = @"jianpai/Img/imgPerfectUpload";

typedef NS_ENUM(NSInteger, YHAddPicPerfectShopType) {
    YHAddPicPerfectShopTypeUp = 0,
    YHAddPicPerfectShopTypeMiddle,
    YHAddPicPerfectShopTypeDown,
};

@interface YHUploadPicPerfectShopVC ()
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
/** 标记用户现在将选择哪个imgView的图片:上中下 */
@property (nonatomic, assign) YHAddPicPerfectShopType addPicType;
/** upload check model */
@property (nonatomic, strong) YHUploadCheckModel *uploadCheckM;
/** uploadPic result model */
@property (nonatomic, strong) YHUploadPicResult *uploadResult;

@end

@implementation YHUploadPicPerfectShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)setup{
    
    [super setup];
}

#pragma mark ------------------------------------------
#pragma mark network methods
//4.通知服务器已上传
- (void)informServerDidUploadPicWithImagePaths:(NSArray *)imageOSSPaths md5String:(NSString *)md5 success:(void (^)(id _Nonnull responseObj))success failure:(void (^)(NSError * _Nonnull error))failure{
    //1.准备参数
    YHUploadPicParam *param = [[YHUploadPicParam alloc] init];
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    
    //转变为中间用','隔开的网络参数
    NSString *imgParam = [imageOSSPaths stringWithStringArray];
    param.img = imgParam;
    
    param.md5s = md5;
    NSDictionary *paramDic = [param mj_keyValues];
    
    [YHHttpTool postNotByJSONDataWithUrl:strUrlUploadOfPerfect params:paramDic success:^(id  _Nonnull responseObj) {
        success(responseObj);

    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)uploadAction:(UIButton *)sender {
    
    sender.enabled = NO;
    [self.pickedImages removeAllObjects];
    //1.判断用户是否选择了图片
    NSArray *imageViews = @[self.upImageView, self.middleImageView, self.downImageView];
    self.pickedImages = [self getImagesWithImageViews:imageViews];
    if (!self.pickedImages.count) {//前图片为空
        [MBProgressHUD showError:@"亲,请选择上传照片."];
        sender.enabled = YES;
        return;
    }
    
    //1.1 判断用户是否选择了相同的图片
    BOOL isSameImages = [self isSameImagesInImages:self.pickedImages];
    if (isSameImages) {
        [self showAlertVcWithMessage:@"同1张图片不可上传2次.请选择其它图片."];
        sender.enabled = YES;
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在上传..."];
    //2.判断用户选择的图片是否上传过
    //得到如果有多个,则用','隔开的md5.
    NSString *md5 = [self getMd5ParamOfUploadWithImages:self.pickedImages];
    YHMd5CheckParam *param = [[YHMd5CheckParam alloc] init];
    param.md = md5;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeHuaShanPerfect;
    
    [YHHttpTool checkMd5IsExist:param success:^(id  _Nonnull responseObj) {
        YHUploadPicResult *result = [YHUploadPicResult mj_objectWithKeyValues:responseObj];
        BOOL isOk = result.uploadPicStatus == YHUploadPicStatusTypeSuccess;
#if DEBUG
//        isOk = 1;
#endif
        if (isOk) {
            
            //3.上传图片到oss
            NSArray *imagesToUpload = self.pickedImages;
            
            [self uploadPicToOssWithImagesToUpload:imagesToUpload saveImageFolder:@"per" uploadError:^(NSError *error, NSArray *imageOSSPaths) {
                if (error) {
                    [SVProgressHUD dismiss];
                    self.progressViewOfUpload.hidden = YES;
                    [MBProgressHUD showError:@"图片上传失败,请稍后重试."];
                    sender.enabled = YES;
                    YHLog(@"error = %@", error);
                    return ;
                }else{ //没有错误,上传成功
#if DEBUG
//                    return;
#endif
                    //4.通知服务器已上传
                    [self informServerDidUploadPicWithImagePaths:imageOSSPaths md5String:md5 success:^(id _Nonnull responseObj) {
                        
                        self.uploadResult = [YHUploadPicResult mj_objectWithKeyValues:responseObj];
                        NSString *msg = self.uploadResult.message;
                        if (self.uploadResult.stuatus.integerValue == 1) {//服务器返回成功
                            [MBProgressHUD showSuccess:@"上传成功"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [self dismissViewControllerAnimated:YES completion:nil];
                            });
                        }else{//服务器返回失败
                            [SVProgressHUD dismiss];
                            [self showAlertVcWithMessage:msg];
                            sender.enabled = YES;
                        }
                        
                    } failure:^(NSError * _Nonnull error) {
                        [SVProgressHUD dismiss];
                        [MBProgressHUD showError:@"请检查网络,稍后重试."];
                        YHLog(@"error = %@", error);
                        sender.enabled = YES;
                        return ;
                    }];
                }
            }];
        }else{
            [SVProgressHUD dismiss];
            NSString *str = @"同1张图片不可上传2次";
            if (result.uploadPicStatus == YHUploadPicStatusTypeAlreadyUploaded) {
                str = result.message;
            }else{
                str = [NSString stringWithFormat:@"%@:%@",result.message, str];
            }
            [self showAlertVcWithMessage:str];
            sender.enabled = YES;
            return ;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"上传失败,请检查网络."];
        YHLog(@"error = %@", error);
        sender.enabled = YES;
    }];
}

//添加图片,3合1事件,tag分别为10,11,12
- (IBAction)addPicAction:(UIButton *)btn {
    YHFunc
    YHAlbumTool *album = [YHAlbumTool shareAlbumTool];
    [album openAlbumWithVc:self];
    self.addPicType = btn.tag - 10;

}

- (IBAction)HelpAction:(YHHelpButton *)sender {
    YHHelpInfoParam *param = [[YHHelpInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeHuaShanPerfect;
    
    sender.paramOfHelpInfo = param;

    [sender setShowHelpImages:YHShowHelpImagesTypeNo];
}

#pragma mark ------------------------------------------
#pragma mark YHAlbumTool delegate
- (void)albumToolDidSelectImage:(UIImage *)image albumTool:(YHAlbumTool *)albumTool{
    switch (self.addPicType) {
        case YHAddPicPerfectShopTypeUp:{
            
            self.upImageView.hidden = NO;
            self.upImageView.image = image;
            
            break;
        }
        case YHAddPicPerfectShopTypeMiddle:{
            self.middleImageView.hidden = NO;
            self.middleImageView.image = image;
            break;
        }
        case YHAddPicPerfectShopTypeDown:{
            self.downImageView.hidden = NO;
            self.downImageView.image = image;
            break;
        }
        default:
            break;
    }
}

@end
