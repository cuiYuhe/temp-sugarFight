//
//  YHSwordSongVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSwordSongVc.h"
#import "YHGridImagesCollectionView.h"
#import "YHSwordSongCell.h"
#import "YHGridImagesHeaderView.h"
#import "YHSwordSongImgsResult.h"
#import "YHZanPicResult.h"
#import "YHLoginModel.h"
#import "YHPopNoZanView.h"
#import "YHZanPicParam.h"
#import "YHCustomSSImgModel.h"
#import "YHPostCmtParam.h"

static NSString *const YHStrUrlDownBattleImg = @"jianpai/Img/downBattleImg";
static NSString *const YHStrUrlZan = @"jianpai/Score/zan";

@interface YHSwordSongVc ()<UICollectionViewDataSource, UICollectionViewDelegate, YHGridImagesCellDelegate>

@property (weak, nonatomic) IBOutlet YHGridImagesCollectionView *collectionView;
/** 再来一轮按钮 */
@property (weak, nonatomic) IBOutlet UIButton *onceMoreBtn;
/** YHZanResult model */
@property (nonatomic, strong) YHZanPicResult *zanPicResultM;
/** 剩下的赞的数量 */
@property (nonatomic, assign) NSInteger zanRemains;
@property (weak, nonatomic) IBOutlet UIButton *cmtBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
/** 剩余点赞数量 */
@property (weak, nonatomic) IBOutlet UIButton *leftZanTimesBtn;
///举报按钮
@property (weak, nonatomic) IBOutlet YHAccusationBtn *accuseBtn;
/** YHSwordSongImgsResult 模型,图片所有数据 */
@property (nonatomic, strong) YHSwordSongImgsResult *imgsResult;
/** 此数组中包含一个模型数组:YHCustomSSImgModel */
@property (nonatomic, strong) NSMutableArray *ssImgMs;
@property (weak, nonatomic) IBOutlet UIImageView *titleText;

@end

@implementation YHSwordSongVc
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSMutableArray<YHCustomSSImgModel *> *)ssImgMs{
    if (!_ssImgMs) {
        _ssImgMs = [NSMutableArray arrayWithCapacity:YHNumberOfSectionsOfGridImages];
        for (NSInteger i = 0; i < YHNumberOfSectionsOfGridImages; i++){
            //模型数组
            NSMutableArray<YHCustomSSImgModel *> *ms = [NSMutableArray arrayWithCapacity:YHNumberOfColumnsInEachSectionOfGridImages];
            for (NSInteger j = 0; j < YHNumberOfColumnsInEachSectionOfGridImages; j++) {
                YHCustomSSImgModel *ssImgM = [[YHCustomSSImgModel alloc] init];
                [ms addObject:ssImgM];
            }
            [_ssImgMs addObject:ms];
        }
    }
    return _ssImgMs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //加载图片
    [self loadImages];
}

- (void)setup{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[YHSwordSongCell class] forCellWithReuseIdentifier:[YHSwordSongCell identifier]];
    
    [self isHideLeftZanBtn:self.leftZanTimesBtn];
    
    //title文字
    YHTitlesResult *titlesM = [GlobeSingle shareGlobeSingle].titlesM;
    [titlesM setTitleImageWithTitleType:YHTitleTypeBattle_title titleImageView:self.titleText];
    //设置标题,防止审核不过
    NSString *userName = [GlobeSingle shareGlobeSingle].loginM.data.user.userName;
    if ([userName isEqualToString:@"tt1"]) {
        self.titleText.image = [UIImage imageNamed:@"titleText_biGuanXiuLian"];
    }
}

- (void)setupZan{
    [self.leftZanTimesBtn setNormalTitle:[NSString stringWithFormat:@"剩%@", self.imgsResult.imgs.zanRemain]];
    self.zanRemains = self.imgsResult.imgs.zanRemain.integerValue;
    self.zanPicResultM.zanRemain = self.imgsResult.imgs.zanRemain;
}

- (void)setupAfterGetImgList{
    YHFunc
    void(^setCustomModel)(NSString *imgUrl, YHCustomSSImgModel *ssImgM) = ^(NSString *imgUrl, YHCustomSSImgModel *ssImgM){
        if (imgUrl) {
            ssImgM.haveImg = YES;
            ssImgM.imgUrl = imgUrl;
            //为了之后判断是否下载完成全部图片
//            self.imagesDic[imgUrl] = nil;
            ssImgM.imageCached = self.imagesDic[imgUrl];
        }else{
            ssImgM.haveImg = NO;
            ssImgM.imgUrl = nil;
            ssImgM.imageCached = nil;
        }
    };
    //设置模型
    for (NSInteger i = 0; i < YHNumberOfSectionsOfGridImages; i++) {
        for (NSInteger j = 0; j < YHNumberOfColumnsInEachSectionOfGridImages; j++) {
            YHCustomSSImgModel *ssImgM = self.ssImgMs[i][j];
            if (i == 0) {
                if (j == 0) {
                    setCustomModel(self.imgsResult.imgs.store1Img1, ssImgM);
                }else if (j == 1){
                    setCustomModel(self.imgsResult.imgs.store1Img2, ssImgM);
                }
            }else if (i == 1) {
                if (j == 0) {
                    setCustomModel(self.imgsResult.imgs.store2Img1, ssImgM);
                }else if (j == 1){
                    setCustomModel(self.imgsResult.imgs.store2Img2, ssImgM);
                }
            }else if (i == 2) {
                if (j == 0) {
                    setCustomModel(self.imgsResult.imgs.store3Img1, ssImgM);
                }else if (j == 1){
                    setCustomModel(self.imgsResult.imgs.store3Img2, ssImgM);
                }
            }
        }
    }
    [self.collectionView reloadData];
    
    [self setupZan];
}

///赞后并提交到服务器的操作
- (void)setupAfterZan{
    self.zanRemains = self.zanPicResultM.zanRemain.integerValue;
    [self.leftZanTimesBtn setNormalTitle:[NSString stringWithFormat:@"剩%zd", self.zanRemains]];
}

#pragma mark ------------------------------------------
#pragma mark internet method
///加载图片
- (void)loadImages{
    NSDictionary *param = @{@"uid" : [GlobeSingle shareGlobeSingle].userID};
    [SVProgressHUD showWithStatus:nil];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlDownBattleImg params:param success:^(id  _Nonnull responseObj) {
        self.imgsResult = [YHSwordSongImgsResult mj_objectWithKeyValues:responseObj];
        if (self.imgsResult.status.integerValue == 1) {
            [self setupAfterGetImgList];
        }else{
            [SVProgressHUD dismiss];
            [self setupZan];
            [MBProgressHUD showError:self.imgsResult.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        self.onceMoreBtn.enabled = YES;
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)back:(UIButton *)sender {
    [self dismissVc];
}

- (IBAction)commentAction:(UIButton *)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHCommentsListVC class]) bundle:nil];
    YHCommentsListVC *vc = [sb instantiateInitialViewController];
    
    //1.得到评论列表的参数
    YHCommentsListParam *p = [[YHCommentsListParam alloc] init];
    p.imgUrl = self.imgsResult.imgs.store1Img1;
    p.category = @(YHCategoryTypeBattleGridImages);
    p.imgId = self.imgsResult.imgs.imgId;
    vc.getCommentparam = p;
    
    //2.发表评论的参数
    YHPostCmtParam *pstCmtP = [[YHPostCmtParam alloc] init];
    pstCmtP.category = @(YHCategoryTypeBattleGridImages);
    pstCmtP.imgId = p.imgId;
    pstCmtP.imgUrl = p.imgUrl;
    pstCmtP.uid = [GlobeSingle shareGlobeSingle].userID;
    pstCmtP.token = [GlobeSingle shareGlobeSingle].uuid;
    vc.postCmtParam = pstCmtP;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

- (IBAction)onceMoreAction:(UIButton *)sender {
    sender.enabled = NO;
    self.cmtBtn.enabled = NO;
    self.zanBtn.enabled = NO;
    self.accuseBtn.enabled = YES;
    [self loadImages];
}
///举报
- (IBAction)accuseAction:(YHAccusationBtn *)accusBtn {
    //accusDelegate的举报参数
    YHAccuationParam *param = [[YHAccuationParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.iid = self.imgsResult.imgs.imgId;
    accusBtn.accusDelegate.paramOfAccusation = param;
    
    [accusBtn.accusDelegate accuseWithVc:self];
}

- (IBAction)helpAction:(YHHelpButton *)sender {
    YHHelpInfoParam *param = [[YHHelpInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeBattleGridImages;
    sender.paramOfHelpInfo = param;
    [sender setShowHelpImages:YHShowHelpImagesTypeNo];
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
    param.puid = self.imgsResult.imgs.userId;
    if (!param.puid)  {
        YHLog(@"puid = nil");
        return;
    }
    param.category = @(YHCategoryTypeBattleGridImages);
    param.token = [GlobeSingle shareGlobeSingle].uuid;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.imgId = self.imgsResult.imgs.imgId;
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
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}


#pragma mark ------------------------------------------
#pragma mark UICollectionView data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return YHNumberOfSectionsOfGridImages;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return YHNumberOfColumnsInEachSectionOfGridImages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YHSwordSongCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHSwordSongCell identifier] forIndexPath:indexPath];
    cell.imgM = self.ssImgMs[indexPath.section][indexPath.row];
    cell.delegate = self;
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
#pragma mark YHGridImagesCellDelegate
- (void)gridImagesCell:(YHGridImagesCell *)cell didFinishDownloadImage:(UIImage *)image imageStringUrl:(NSString *)stringUrl{
    if (image) {//成功下载图片
        //保存图片
        if (stringUrl) {
            self.imagesDic[stringUrl] = image;
        }
        //判断图片是否全部下载完成
        __block BOOL isAllDownload = YES;
        [self.imagesDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (!obj) {
                isAllDownload = NO;
                *stop = YES;
            }
        }];
        
        if (isAllDownload) {
            self.onceMoreBtn.enabled = YES;
            self.cmtBtn.enabled = YES;
            self.zanBtn.enabled = YES;
            self.accuseBtn.enabled = YES;
            [SVProgressHUD dismiss];
        }
        
    }else{//下载图片失败
        [MBProgressHUD showError:@"图片下载失败,请检查网络,稍后重试."];
        self.onceMoreBtn.enabled = YES;
    }
}


@end
