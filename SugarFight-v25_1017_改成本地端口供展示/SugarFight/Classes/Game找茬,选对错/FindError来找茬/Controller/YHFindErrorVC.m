//
//  YHFindErrorVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHFindErrorVC.h"
#import "YHGetErrorPicResult.h"
#import <UIImageView+WebCache.h>
#import "YHPopNoZanView.h"
#import "MJPhotoLoadingView.h"
#import "YHDateTool.h"
#import "YHZanPicParam.h"
#import "YHZanPicResult.h"
#import "YHCommentsListVC.h"
#import "YHCommentsListParam.h"
#import "YHPostCmtParam.h"
#import "YHLoginModel.h"

static NSString *const YHStrUrlDownBcrImg = @"jianpai/Img/downbcrimg";
static NSString *const YHStrUrlZan = @"jianpai/Score/zan";

@interface YHFindErrorVC ()
/** 剩余点赞数量 */
@property (weak, nonatomic) IBOutlet UIButton *leftZanTimesBtn;
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *beforeImgView;
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *afterImgView;
/** YHGetErrorPicResult model */
@property (nonatomic, strong) YHGetErrorPicResult *errorPicM;
/** YHZanResult model */
@property (nonatomic, strong) YHZanPicResult *zanResultM;
@property (weak, nonatomic) IBOutlet UIButton *cmtBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
///举报按钮
@property (weak, nonatomic) IBOutlet YHAccusationBtn *accuseBtn;
/** 再来一轮按钮 */
@property (weak, nonatomic) IBOutlet UIButton *onceMoreBtn;

/** 剩下的赞的数量 */
@property (nonatomic, assign) NSInteger zanRemains;
/** title文字 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;

@end

@implementation YHFindErrorVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setup];
    //加载图片
    [self loadErrorImgs];
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setup{
    //如果是vip,隐藏剩余赞数btn
    [self isHideLeftZanBtn:self.leftZanTimesBtn];
    //title文字
    YHTitlesResult *titlesM = [GlobeSingle shareGlobeSingle].titlesM;
    [titlesM setTitleImageWithTitleType:YHTitleTypeBcr_title titleImageView:self.titleImgView];
}

///网络请求到图片后的操作
- (void)setupAfterGetPic{
    NSArray *imageViews = @[self.beforeImgView, self.afterImgView];
    NSArray *urls = @[self.errorPicM.img1, self.errorPicM.img2];
    WeakSelf
    self.accuseBtn.enabled = NO;
    [self setImagesWithImageViews:imageViews stringUrls:urls completed:^{
        //可赞,可评,可举报,可'再来一轮'
        weakSelf.cmtBtn.enabled = YES;
        weakSelf.zanBtn.enabled = YES;
        weakSelf.accuseBtn.enabled = YES;
        weakSelf.onceMoreBtn.enabled = YES;
    } failed:^(NSError *error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        weakSelf.onceMoreBtn.enabled = YES;
        YHLog(@"error = %@", error);
    }];
    
    [self.leftZanTimesBtn setNormalTitle:[NSString stringWithFormat:@"剩%@", self.errorPicM.zanRemain]];
    self.zanRemains = self.errorPicM.zanRemain.integerValue;
}

///赞后并提交到服务器的操作
- (void)setupAfterZan{
    NSInteger leftZanCount = self.zanResultM.zanRemain.integerValue;
    [self.leftZanTimesBtn setNormalTitle:[NSString stringWithFormat:@"剩%zd", leftZanCount]];
    //更新剩余赞的数量
    self.zanRemains = self.zanResultM.zanRemain.integerValue;
    
}

///加载图片
- (void)loadErrorImgs{
    NSDictionary *param = @{@"uid" : [GlobeSingle shareGlobeSingle].userID};
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlDownBcrImg params:param success:^(id  _Nonnull responseObj) {
        
        self.errorPicM = [YHGetErrorPicResult mj_objectWithKeyValues:responseObj];
        if (!self.errorPicM.img1 && !self.errorPicM.img2) {
            [MBProgressHUD showError:@"没有图片信息"];
            return ;
        }
        [self setupAfterGetPic];
    } failure:^(NSError * _Nonnull error) {
        
        self.onceMoreBtn.enabled = YES;
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)zanAction:(UIButton *)sender {
    
    if ([GlobeSingle shareGlobeSingle].loginM.vipLevel == YHVipLevelTypeCommon) {
        //不是vip时才显示这个,专门针对于普通用户的提示view:没赞啦.而vip的拥有的赞数是不限制的.
        if (!self.zanRemains){//没有赞了
            YHPopNoZanView *zv = [YHPopNoZanView popNoZanView];
            [zv show];
            return;
        }
    }
    
    YHZanPicParam *param = [[YHZanPicParam alloc] init];
    param.puid = self.errorPicM.userId;
    if (!param.puid) {
        YHLog(@"puid = nil");
        return;
    }
    param.category = @(YHCategoryTypePrideBcr);
    param.token = [GlobeSingle shareGlobeSingle].uuid;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.imgId = self.errorPicM.bcrimgId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlZan params:paramDic success:^(id  _Nonnull responseObj) {
        self.zanResultM = [YHZanPicResult mj_objectWithKeyValues:responseObj];
        if (self.zanResultM.status.integerValue == 1) {
            [MBProgressHUD showSuccess:@"赞数 +1"];
            [self setupAfterZan];
        }else{
            [MBProgressHUD showError:self.zanResultM.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (IBAction)commentAction:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHCommentsListVC class]) bundle:nil];
    YHCommentsListVC *vc = [sb instantiateInitialViewController];
    YHCommentsListParam *p = [[YHCommentsListParam alloc] init];
    p.imgUrl = self.errorPicM.img1;
    p.category = @(YHCategoryTypePrideBcr);
    p.imgId = self.errorPicM.bcrimgId;
    vc.getCommentparam = p;
    
    //2.发表评论的参数
    YHPostCmtParam *pstCmtP = [[YHPostCmtParam alloc] init];
    pstCmtP.category = @(YHCategoryTypePrideBcr);
    pstCmtP.imgId = self.errorPicM.bcrimgId;
    pstCmtP.imgUrl = self.errorPicM.img1;
    pstCmtP.uid = [GlobeSingle shareGlobeSingle].userID;
    pstCmtP.token = [GlobeSingle shareGlobeSingle].uuid;
    vc.postCmtParam = pstCmtP;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

- (IBAction)onceMoreAction:(UIButton *)sender {
    
    self.beforeImgView.image = nil;
    self.afterImgView.image = nil;
    sender.enabled = NO;
    self.zanBtn.enabled = NO;
    self.cmtBtn.enabled = NO;
    [self loadErrorImgs];
}

///举报
- (IBAction)accuseAction:(YHAccusationBtn *)accusBtn {
    
    //accusDelegate的举报参数
    YHAccuationParam *param = [[YHAccuationParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.iid = self.errorPicM.bcrimgId;
    accusBtn.accusDelegate.paramOfAccusation = param;
    
    [accusBtn.accusDelegate accuseWithVc:self];
}

- (IBAction)helpAction:(YHHelpButton *)sender {
    YHHelpInfoParam *param = [[YHHelpInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypePrideBcr;
    sender.paramOfHelpInfo = param;

    [sender setShowHelpImages:YHShowHelpImagesTypeNo];
}

@end
