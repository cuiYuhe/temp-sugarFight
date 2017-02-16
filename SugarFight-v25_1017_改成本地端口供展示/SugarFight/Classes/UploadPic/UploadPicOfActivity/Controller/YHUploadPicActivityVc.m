
//
//  YHUploadPicActivityVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/9.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHUploadPicActivityVc.h"
#import "YHGridImagesHeaderView.h"
#import "YHUploadPicActvtyCell.h"
#import "YHGridImagesCollectionView.h"
#import "YHUploadPicGridParam.h"
#import "UIImage+Extension.h"
#import "YHMd5CheckParam.h"

static NSString *const YHStrUrlUploadOfGridImgs = @"jianpai/Img/imgBattleUpload";
static NSString *const YHStrUrlGetHelp = @"jianpai/Msg/getHelpImg";

@interface YHUploadPicActivityVc ()<UICollectionViewDataSource, UICollectionViewDelegate, YHAlbumToolDelegate>
/** 选择图片 */
@property (weak, nonatomic) IBOutlet YHGridImagesCollectionView *collectionView;
/** 选择的图片字典: indexPath : UIImage */
@property (nonatomic, strong) NSMutableDictionary *pickedImagesDic;
/**上传Grid图片成功时的参数数组.这个数组中有3个子数组a,分别为storeImg1,2,3,,a中包含2个YHSingleImgParam模型 */
@property (nonatomic, strong) NSMutableArray *uploadSucProperty;
@property (weak, nonatomic) IBOutlet YHHelpButton *helpBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;

@end

@implementation YHUploadPicActivityVc
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSMutableDictionary *)pickedImagesDic{
    if (!_pickedImagesDic) {
        self.pickedImagesDic = [NSMutableDictionary dictionary];
    }
    return _pickedImagesDic;
}

- (NSMutableArray *)uploadSucProperty{
    if (!_uploadSucProperty) {
        self.uploadSucProperty = [NSMutableArray array];
        
        for (NSInteger i = 0; i < YHNumberOfSectionsOfGridImages; i++) {
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (NSInteger j = 0; j < YHNumberOfColumnsInEachSectionOfGridImages; j++) {
                YHSingleImgParam *param = [[YHSingleImgParam alloc] init];
                [modelArray addObject:param];
            }
            [self.uploadSucProperty addObject:modelArray];
        }
    }
    return _uploadSucProperty;
}

#pragma mark ------------------------------------------
#pragma mark initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //请求是否显示引导页
    [self showHelpInfoWithShowImageType:YHShowHelpImagesTypeLetsSee];
}

- (void)setup{
    
    [super setup];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YHUploadPicActvtyCell class] forCellWithReuseIdentifier:[YHUploadPicActvtyCell identifier]];
    
    //title文字
    YHTitlesResult *titlesM = [GlobeSingle shareGlobeSingle].titlesM;
    [titlesM setTitleImageWithTitleType:YHTitleTypeBattle_title titleImageView:self.titleImgView];
}

///显示帮助信息
- (void)showHelpInfoWithShowImageType:(YHShowHelpImagesType)showType{
    YHHelpInfoParam *param = [[YHHelpInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeBattleGridImages;
    self.helpBtn.paramOfHelpInfo = param;
    
    //请求是否显示引导页
    [self.helpBtn setShowHelpImages:showType];
}

#pragma mark ------------------------------------------
#pragma mark network methods
//4.通知服务器已上传
- (void)informServerDidUploadPicWithImagePaths:(NSArray *)imageOSSPaths md5String:(NSString *)md5 success:(void (^)(id _Nonnull responseObj))success failure:(void (^)(NSError * _Nonnull error))failure{
    //1.准备参数
    YHUploadPicGridParam *param = [[YHUploadPicGridParam alloc] init];
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    
    __block NSInteger index = 0;
    [self.pickedImagesDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UIImage *image, BOOL * _Nonnull stop) {
        
        YHSingleImgParam *imgParam = self.uploadSucProperty[indexPath.section][indexPath.item];
        imgParam.imgUrl = imageOSSPaths[index];
        imgParam.imgMd5 = [image yh_md5HashFromUIImage];
#if DEBUG
//        imgParam.imgMd5 = [NSString stringWithFormat:@"%---------zd%zd%zd", index+testMd5,index+testMd5,index+testMd5];
//        YHLog(@"imgMd5 = %@", imgParam.imgMd5);
#endif
        index++;
        
//        NSDictionary *dic = [imgParam mj_keyValues];
        self.uploadSucProperty[indexPath.section][indexPath.row] = imgParam;
    }];
    
    param.storeImg1 = self.uploadSucProperty[0];
    param.storeImg2 = self.uploadSucProperty[1];
    param.storeImg3 = self.uploadSucProperty[2];
    
    NSDictionary *paramDic = [param mj_keyValues];
    
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlUploadOfGridImgs params:paramDic success:^(id  _Nonnull responseObj) {
        success(responseObj);
        
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)compareIndexPath:(NSIndexPath *)indexPath toAnother:(NSIndexPath *)anotherIndexPath{
    return (indexPath.section > anotherIndexPath.section) || (indexPath.section == anotherIndexPath.section && indexPath.item > anotherIndexPath.item);
}

- (IBAction)submitAction:(UIButton *)sender {
    
    sender.enabled = NO;
    [self.pickedImages removeAllObjects];
    
    //1.是否选择了图片
    [self.pickedImagesDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UIImage *image, BOOL * _Nonnull stop) {

        [self.pickedImages addObject:image];
    }];
    
    if (!self.pickedImages.count) {
        [MBProgressHUD showError:@"亲,请选择上传照片."];
        sender.enabled = YES;
        return;
    }
    
    //2.判断选择的图片是否相同
    BOOL isSameImages = [self isSameImagesInImages:self.pickedImages];
    if (isSameImages) {
        [self showAlertVcWithMessage:@"同1张图片不可上传2次.请选择其它图片."];
        sender.enabled = YES;
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在上传..."];
    //2.判断用户选择的图片是否上传过
    //拿到排序的图片,从小到大排序
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSMutableArray *pics = [NSMutableArray array];
    for (NSInteger s = 0; s < YHNumberOfSectionsOfGridImages; s++) {
        for (NSInteger r = 0; r < YHNumberOfColumnsInEachSectionOfGridImages; r++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:r inSection:s];
            [indexPaths addObject:indexPath];
            
            if (self.pickedImagesDic[indexPath]) {
                [pics addObject:self.pickedImagesDic[indexPath]];
            }
        }
    }
    
    NSString *md5 = [self getMd5ParamOfUploadWithImages:pics];
    YHMd5CheckParam *param = [[YHMd5CheckParam alloc] init];
    param.md = md5;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeBattleGridImages;
    [YHHttpTool checkMd5IsExist:param success:^(id  _Nonnull responseObj) {
        YHUploadPicResult *result = [YHUploadPicResult mj_objectWithKeyValues:responseObj];
        BOOL isOk = result.uploadPicStatus == 1;
#if DEBUG
//        isOk = YES;
#endif
        if (isOk) {
            
            //3.上传图片到oss
            [self uploadPicToOssWithImagesToUpload:pics saveImageFolder:@"per" uploadError:^(NSError *error, NSArray *imageOSSPaths) {
                if (error) {
                    self.progressViewOfUpload.hidden = YES;
                    [SVProgressHUD dismiss];
                    [MBProgressHUD showError:@"图片上传失败,请稍后重试."];
                    sender.enabled = YES;
                    YHLog(@"error = %@", error);
                    return;
                }else{ //没有错误,上传成功
#if DEBUG
                    //test
//                    sender.enabled = YES;
//                    [SVProgressHUD dismiss];
//                    return;
                    
#endif
                    //4.通知服务器已上传
                    [self informServerDidUploadPicWithImagePaths:imageOSSPaths md5String:md5 success:^(id _Nonnull responseObj) {

                        YHBaseModel *baseM = [YHBaseModel mj_objectWithKeyValues:responseObj];
                        if (baseM.status.integerValue == 1) {//服务器返回成功
                            [MBProgressHUD showSuccess:@"上传成功"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [self dismissViewControllerAnimated:YES completion:nil];
                            });
                        }else{//服务器返回失败
                            [SVProgressHUD dismiss];
                            [self showAlertVcWithMessage:baseM.message];
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

- (IBAction)HelpAction:(YHHelpButton *)sender {
    
    [self showHelpInfoWithShowImageType:YHShowHelpImagesTypeAlways];
}

#pragma mark ------------------------------------------
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return YHNumberOfSectionsOfGridImages;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return YHNumberOfColumnsInEachSectionOfGridImages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YHUploadPicActvtyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHUploadPicActvtyCell identifier] forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YHGridImagesHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[YHGridImagesHeaderView identifier] forIndexPath:indexPath];
        
        headerView.imgName = [NSString stringWithFormat:@"upload_%zd_shop", indexPath.section + 1];
        
        return headerView;
    }
    return nil;
}

#pragma mark ------------------------------------------
#pragma mark UICollectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YHAlbumTool *album = [YHAlbumTool shareAlbumTool];
    [album openAlbumWithVc:self];
    album.delegate = self;

}

#pragma mark ------------------------------------------
#pragma mark YHAlbumTool delegate
- (void)albumToolDidSelectImage:(UIImage *)image albumTool:(YHAlbumTool *)albumTool{
    
    NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
    YHUploadPicActvtyCell *cell = (YHUploadPicActvtyCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.imageToShow = image;
    
    self.pickedImagesDic[indexPath] = image;
}

@end
