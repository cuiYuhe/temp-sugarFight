//
//  YHChooseTFVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/31.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHChooseTFVC.h"
#import "YHGetTFPicResult.h"
#import <UIImageView+WebCache.h>
#import "YHZanPicParam.h"
#import "YHZanPicResult.h"
#import "YHPopNoZanView.h"
#import "YHCommentModel.h"
#import "YHPostCmtParam.h"

#import "YHLoginModel.h"

static NSString *const YHStrUrlDownPerImg = @"jianpai/Img/downperimg";
static NSString *const YHStrUrlZan = @"jianpai/Score/zan";

@interface YHChooseTFVC ()

/** 剩余点赞数量 */
@property (weak, nonatomic) IBOutlet UIButton *leftZanTimesBtn;
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *upImgView;
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *midImgView;
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *downImgView;
/** YHGetTFPicResult */
@property (nonatomic, strong) YHGetTFPicResult *tfPicM;
/** YHZanResult model */
@property (nonatomic, strong) YHZanPicResult *zanPicResultM;
@property (weak, nonatomic) IBOutlet UIButton *cmtBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
///举报按钮
@property (weak, nonatomic) IBOutlet YHAccusationBtn *accuseBtn;
/** 再来一轮按钮 */
@property (weak, nonatomic) IBOutlet UIButton *onceMoreBtn;

/** 剩下的赞的数量 */
@property (nonatomic, assign) NSInteger zanRemains;

@end

@implementation YHChooseTFVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    //加载图片
    [self loadTFImg];
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setup{
    [self isHideLeftZanBtn:self.leftZanTimesBtn];
}

///网络请求到图片后的操作
- (void)setupAfterGetPic{
    NSMutableArray *imageVs = [NSMutableArray array];
    NSMutableArray *strUrls = [NSMutableArray array];
    if (self.tfPicM.img1) {
        [imageVs addObject:self.upImgView];
        [strUrls addObject:self.tfPicM.img1];
    }
    if (self.tfPicM.img2) {
        [imageVs addObject:self.midImgView];
        [strUrls addObject:self.tfPicM.img2];
    }
    if (self.tfPicM.img3) {
        [imageVs addObject:self.downImgView];
        [strUrls addObject:self.tfPicM.img3];
    }
    
    self.accuseBtn.enabled = NO;
    WeakSelf;
    [self setImagesWithImageViews:imageVs stringUrls:strUrls completed:^{
        weakSelf.cmtBtn.enabled = YES;
        weakSelf.zanBtn.enabled = YES;
        weakSelf.accuseBtn.enabled = YES;
        weakSelf.onceMoreBtn.enabled = YES;
        
    } failed:^(NSError *error) {
        weakSelf.onceMoreBtn.enabled = YES;
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
    
    [self.leftZanTimesBtn setNormalTitle:[NSString stringWithFormat:@"剩%@", self.tfPicM.zanRemain]];
    self.zanRemains = self.tfPicM.zanRemain.integerValue;
    self.zanPicResultM.zanRemain = self.tfPicM.zanRemain;
}

///赞后并提交到服务器的操作
- (void)setupAfterZan{
    self.zanRemains = self.zanPicResultM.zanRemain.integerValue;
    [self.leftZanTimesBtn setNormalTitle:[NSString stringWithFormat:@"剩%zd", self.zanRemains]];
}

#pragma mark ------------------------------------------
#pragma mark internet method
///加载图片
- (void)loadTFImg{
    NSDictionary *param = @{@"uid" : [GlobeSingle shareGlobeSingle].userID};
    [SVProgressHUD showWithStatus:nil];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlDownPerImg params:param success:^(id  _Nonnull responseObj) {
        self.tfPicM = [YHGetTFPicResult mj_objectWithKeyValues:responseObj];
        [SVProgressHUD dismiss];
        [self setupAfterGetPic];
        
    } failure:^(NSError * _Nonnull error) {
        
        self.onceMoreBtn.enabled = YES;
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
        [SVProgressHUD dismiss];
    }];
}


#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)zanAction:(UIButton *)sender {
    
    //不是vip时才显示这个,专门针对于普通用户的提示view:没赞啦.而vip的拥有的赞数是不限制的.
    if ([GlobeSingle shareGlobeSingle].loginM.vipLevel == YHVipLevelTypeCommon) {
        if (!self.zanRemains){//没有赞了
                YHPopNoZanView *zv = [YHPopNoZanView popNoZanView];
                [zv show];
                return;
            }
    }
    
    YHZanPicParam *param = [[YHZanPicParam alloc] init];
    param.puid = self.tfPicM.userId;
    if (!param.puid)  {
        YHLog(@"puid = nil");
        return;
    }
    param.category = @(YHCategoryTypeHuaShanPerfect);
    param.token = [GlobeSingle shareGlobeSingle].uuid;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.imgId = self.tfPicM.perimgId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlZan params:paramDic success:^(id  _Nonnull responseObj) {
        self.zanPicResultM = [YHZanPicResult mj_objectWithKeyValues:responseObj];
        if (self.zanPicResultM.status.integerValue == 1) {
            [MBProgressHUD showSuccess:@"赞数 +1"];
            [self setupAfterZan];
        }else{
            [MBProgressHUD showError:self.zanPicResultM.message];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (IBAction)commentAction:(UIButton *)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHCommentsListVC class]) bundle:nil];
    YHCommentsListVC *vc = [sb instantiateInitialViewController];
    
    //1.得到评论列表的参数
    YHCommentsListParam *p = [[YHCommentsListParam alloc] init];
    p.imgUrl = self.tfPicM.img1;
    p.category = @(YHCategoryTypeHuaShanPerfect);
    p.imgId = self.tfPicM.perimgId;
    vc.getCommentparam = p;
    
    //2.发表评论的参数
    YHPostCmtParam *pstCmtP = [[YHPostCmtParam alloc] init];
    pstCmtP.category = @(YHCategoryTypeHuaShanPerfect);
    pstCmtP.imgId = self.tfPicM.perimgId;
    pstCmtP.imgUrl = self.tfPicM.img1;
    pstCmtP.uid = [GlobeSingle shareGlobeSingle].userID;
    pstCmtP.token = [GlobeSingle shareGlobeSingle].uuid;
    vc.postCmtParam = pstCmtP;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

- (IBAction)onceMoreAction:(UIButton *)sender {
    
    sender.enabled = NO;
    //复位总共要加载的数量.因为每次不是必须3张图片,可能1,2,3张.
    self.upImgView.image = nil;
    self.midImgView.image = nil;
    self.downImgView.image = nil;
    
    self.cmtBtn.enabled = NO;
    self.zanBtn.enabled = NO;
    [self loadTFImg];
}

///举报
- (IBAction)accuseAction:(YHAccusationBtn *)accusBtn {
    //accusDelegate的举报参数
    YHAccuationParam *param = [[YHAccuationParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.iid = self.tfPicM.perimgId;
    accusBtn.accusDelegate.paramOfAccusation = param;
    
    [accusBtn.accusDelegate accuseWithVc:self];
}

- (IBAction)helpAction:(YHHelpButton *)sender {
    YHHelpInfoParam *param = [[YHHelpInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeHuaShanPerfect;
    sender.paramOfHelpInfo = param;
    [sender setShowHelpImages:YHShowHelpImagesTypeNo];
}


@end
