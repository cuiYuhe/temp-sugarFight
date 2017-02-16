//
//  YHSeeUploadCommenVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/20.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSeeUploadCommenVc.h"
#import "YHSugarFightWSVC.h"
#import "YHSugarFightNotWSVC.h"
#import "YHSugarFightProvinceAndCityVC.h"
#import "YHSugarFightHeadVC.h"
#import "YHSugarFightDistrictVC.h"
#import "YHMyApplellationVC.h"

static NSString *const YHStrUrlGetDaysList = @"jianpai/Msg/getDayList";

@interface YHSeeUploadCommenVc ()

@end

@implementation YHSeeUploadCommenVc

#pragma mark ------------------------------------------
#pragma mark 子类实现方法
- (YHCategoryType)categoryType{ return -1;}

- (void)getDaysList{return;}

#pragma mark ------------------------------------------
#pragma mark lazy
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
}

- (BOOL)isHavePicWithShiftBtn:(UIButton *)btn{
    NSArray *days = self.daysListM.days;
    
    //情况一:没有图片
    if (!days.count) {
        [MBProgressHUD showError:@"没有上传图片记录."];
        return false;
    }
    
    //情况二:当远程通知传入日期时
    if (self.pushM) {
        
        //日期是否存在
        BOOL isHaveNoteDate = NO;
        //2.1 由评论的通知触发
        if (self.pushM.PING) {
            isHaveNoteDate = [days containsObject:self.pushM.PING.imgTime];
            if (isHaveNoteDate) {
                self.dayIndex = [days indexOfObject:self.pushM.PING.imgTime];
            }
            
        //2.2 由赞的通知触发
        }else if (self.pushM.ZAN){
            isHaveNoteDate = [days containsObject:self.pushM.ZAN.imgTime];
            if (isHaveNoteDate) {
                self.dayIndex = [days indexOfObject:self.pushM.ZAN.imgTime];
            }
        }
        
        if (isHaveNoteDate) {//有后台传入的日期
            return YES;
        }else{
            [MBProgressHUD showError:@"没有此组vip评论的图片."];
            //清空pushM,使用户可以继续加载其它上传的图片
            self.pushM = nil;
            return false;
        }
    }

    
    switch (btn.tag) {
        case 10:{   //点击了左按钮
            //            NSArray *days = self.daysListM.days;
            self.dayIndex++;
            if (self.dayIndex > days.count - 1) {
                [MBProgressHUD showError:@"没有更早日期的图片."];
                //恢复dayIndex的值,防止用户紧接着点击左按钮
                self.dayIndex--;
                return false;
            }
        }
            break;
        case 11:{//点击了右按钮
            self.dayIndex--;
            if (self.dayIndex < 0) {
                [MBProgressHUD showError:@"没有更后日期的图片."];
                self.dayIndex++;
                return false;
            }
        }
            break;
            
        case 0:{ //第一次加载,主动调用,没有传入btn
            YHLog(@"sender.tag == 0,或没有传入sender");
        }
            break;
            
        default:
            break;
    }
    return YES;
}

///查看评论
- (void)seeCmtsAction{
    [self notice];
    
    YHCommentsListVC *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHCommentsListVC class])];
    vc.hideCmtField = YES;
    
    YHCommentsListParam *param = [[YHCommentsListParam alloc] init];
    YHGetImageModel *model = self.ImgListM.imgs.firstObject;
    if (!model.imgUrl) {//没有获得图片
        [MBProgressHUD showError:@"没有图片,岂有评论?"];
        return;
    }
    param.imgUrl = model.imgUrl;
    param.category = @(self.categoryType);
    vc.getCommentparam = param;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///1.加载照片的日期数据
- (void)getDaysListWithSuccess:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
    YHGetDaysListParam *param = [[YHGetDaysListParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.category = @(self.categoryType);
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetDaysList params:paramDic success:^(id  _Nonnull responseObj) {
        success(responseObj);
        
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

///准备获得上传图片的请求参数
- (NSDictionary *)setupParamForImgListWithDate:(NSString *)date{
    
    YHGetImgListParam *param = [[YHGetImgListParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.category = @(self.categoryType);
    param.imgUploadDay = date;
    NSDictionary *paramDic = [param mj_keyValues];
    return paramDic;
}

///设置指定imageView的image
- (void)setImageToImgView:(NSString *)urlStr imageViewToSet:(YHPopAllScreenImageView *)imgV{
    imgV.image = nil;
    
    //1.先从自己保存的图片中取
    UIImage *savedImage = self.imagesDic[urlStr];
    if (savedImage) {
        imgV.image = savedImage;
        //隐藏hiddenProgressView,防止上一轮图片没有下载成功,会在当前imageV显示.
        imgV.hiddenProgressView = YES;
        return;
    }
    //2.如果没有保存图片,则下载
    [imgV yh_setImageWithUrl:urlStr completed:^(UIImage *image, NSError *error) {
        if (image) {
            self.imagesDic[urlStr] = image;
        }else{
            [MBProgressHUD showError:@"请检查网络,稍后重试."];
            YHLog(@"error = %@", error);
        }
    }];
}

///加载到imgList之后的操作
- (void)setupAfterLoadImgList{
    
    if (self.pushM) {
        //清空远程通知的信息,因为此信息有值代表刚进入当前vc时,要加载通知信息中的日期
        self.pushM = nil;
    }
}

///点击返回的vc跳转操作
- (void)backToLastVc{
    
    NSString *sbName = nil;
    //1.判断到'我的称谓'vc的跳转
    if ([self.presentingViewController isKindOfClass:[YHMyApplellationVC class]]) {
        [self dismissVc];
        return;
    }
    
    //2.判断到homeVc的跳转.是不是远程通知导致的跳转
    YHUserType userType = [GlobeSingle shareGlobeSingle].userType;
    switch (userType) {
        case YHUserTypeCommonNotWS:{
            sbName = NSStringFromClass([YHSugarFightNotWSVC class]);
        }
            break;
        case YHUserTypeCommonWS:{
            sbName = NSStringFromClass([YHSugarFightWSVC class]);
        }
            break;
        case YHUserTypeVipCity:
        case YHUserTypeVipProvince:{
            sbName = NSStringFromClass([YHSugarFightProvinceAndCityVC class]);
        }
            break;
        case YHUserTypeVipDistrict:{
            sbName = NSStringFromClass([YHSugarFightDistrictVC class]);
        }
            break;
        case YHUserTypeVipNation:{
            sbName = NSStringFromClass([YHSugarFightHeadVC class]);
        }
            break;
            
        default:
            break;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///收到远程通知时,reloadData
- (void)setReloadNetworkData:(BOOL)reloadNetworkData{
    [super setReloadNetworkData:reloadNetworkData];
    [self getDaysList];
}

#pragma mark ------------------------------------------
#pragma mark private methods
- (void)notice{
    NSAssert(self.categoryType >= YHCategoryTypeHuaShanPerfect, @"请设置YHCategoryType");
}

@end
