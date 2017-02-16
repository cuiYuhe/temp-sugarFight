//
//  YHUploadPicPerfectShopVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHUploadPicPrideVC.h"
#import "NSArray+Extension.h"
#import "YHImageManager.h"
#import "YHMd5CheckParam.h"

static NSString *const strUrlUploadOfBcr = @"jianpai/Img/imgBcrUpload";

typedef NS_ENUM(NSInteger, YHAddPicPrideType) {
    YHAddPicPrideTypeBefore = 0,
    YHAddPicPrideTypeAfter,
};

@interface YHUploadPicPrideVC ()
@property (weak, nonatomic) IBOutlet UIImageView *beforeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *afterImageView;
/** 标记用户现在将选择哪个imgView的图片:前or后 */
@property (nonatomic, assign) YHAddPicPrideType addPicType;
/** uploadPic result model */
@property (nonatomic, strong) YHUploadPicResult *uploadResult;
/** title文字 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;


@end

@implementation YHUploadPicPrideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)setup{
    
    [super setup];
    //title文字
    YHTitlesResult *titlesM = [GlobeSingle shareGlobeSingle].titlesM;
    [titlesM setTitleImageWithTitleType:YHTitleTypeBcr_title titleImageView:self.titleImgView];
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
    
    [YHHttpTool postNotByJSONDataWithUrl:strUrlUploadOfBcr params:paramDic success:^(id  _Nonnull responseObj) {
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
    YHFunc
    sender.enabled = NO;
    //1.判断用户是否选择了更改前后的两张图片
    NSArray *imageViews = @[self.beforeImageView, self.afterImageView];
    self.pickedImages = [self getImagesWithImageViews:imageViews];
    if (self.pickedImages.count != 2) {//前图片为空
        [MBProgressHUD showError:@"亲,一组照片都要选择."];
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

    //2.判断用户选择的图片是否上传过
    //得到如果有多个,则用','隔开的md5.
    [SVProgressHUD showWithStatus:@"正在上传..."];
    NSString *md5 = [self getMd5ParamOfUploadWithImages:self.pickedImages];
    YHMd5CheckParam *param = [[YHMd5CheckParam alloc] init];
    param.md = md5;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypePrideBcr;
    
    [YHHttpTool checkMd5IsExist:param success:^(id responseObj) {
        YHUploadPicResult *result = [YHUploadPicResult mj_objectWithKeyValues:responseObj];
        BOOL isOk = result.uploadPicStatus == YHUploadPicStatusTypeSuccess;
//#if DEBUG
        //test
//        [YHHttpTool testCheckMd5IsExist:md5];
        
//        isOk = 1;
//#endif
        if (isOk) {
            
            //3.上传图片到oss
            NSArray *imagesToUpload = self.pickedImages;
            [self uploadPicToOssWithImagesToUpload:imagesToUpload saveImageFolder:@"bcr" uploadError:^(NSError *error, NSArray *imageOSSPaths) {
                if (error) {
                    [MBProgressHUD showError:@"图片上传失败,请稍后重试."];
                    self.progressViewOfUpload.hidden = YES;
                    sender.enabled = YES;
                    YHLog(@"error = %@", error);
                    [SVProgressHUD dismiss];
                    return ;
                }else{ //没有错误,上传成功
#ifdef DEBUG
//                    return;
#endif
                    //4.通知服务器已上传
                    [self informServerDidUploadPicWithImagePaths:imageOSSPaths md5String:md5 success:^(id _Nonnull responseObj) {
                        YHLog(@"------server");
                        
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
                        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
                        sender.enabled = YES;
                        YHLog(@"error = %@", error);
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
        YHLog(@"error = %@", error);
        sender.enabled = YES;
    }];
    
}

//添加图片,2合1事件,tag分别为20,21
- (IBAction)addPicAction:(UIButton *)sender {
    YHFunc
    YHAlbumTool *album = [YHAlbumTool shareAlbumTool];
    [album openAlbumWithVc:self];
    self.addPicType = sender.tag - 20;
    
}

- (IBAction)HelpAction:(YHHelpButton *)sender {
    YHHelpInfoParam *param = [[YHHelpInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypePrideBcr;
    sender.paramOfHelpInfo = param;
    
    //显示帮助
    [sender setShowHelpImages:YHShowHelpImagesTypeNo];
}

#pragma mark ------------------------------------------
#pragma mark YHAlbumTool delegate
- (void)albumToolDidSelectImage:(UIImage *)image albumTool:(YHAlbumTool *)albumTool{
    
    if (self.addPicType == YHAddPicPrideTypeBefore) {
        self.beforeImageView.hidden = NO;
        self.beforeImageView.image = image;
        
    }else if(self.addPicType == YHAddPicPrideTypeAfter) {
        self.afterImageView.hidden = NO;
        self.afterImageView.image = image;
    }
}

@end
