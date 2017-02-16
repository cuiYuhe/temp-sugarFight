//
//  YHSeeSwordGrideImgVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/20.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSeeUploadSwordGrideImgVc.h"
#import "YHGridImagesCollectionView.h"
#import "YHSeeUploadGridImgCell.h"
#import "YHGridImagesHeaderView.h"

static NSString *const YHStrUrlGetImgList = @"jianpai/Msg/getImgList";

@interface YHSeeUploadSwordGrideImgVc ()<UICollectionViewDataSource, UICollectionViewDelegate, YHGridImagesCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/** 日期 */
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet YHGridImagesCollectionView *collectionView;
/** 赞的数量, 100个赞,其中30个vip赞 */
@property (weak, nonatomic) IBOutlet UILabel *zanCountLabel;
/** title文字 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;


@end

@implementation YHSeeUploadSwordGrideImgVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //1.加载照片的日期数据,并加载图片
    [self getDaysList];
}

- (void)setup{
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YHSeeUploadGridImgCell class] forCellWithReuseIdentifier:[YHSeeUploadGridImgCell identifier]];
    
    //title文字
    YHTitlesResult *titlesM = [GlobeSingle shareGlobeSingle].titlesM;
    [titlesM setTitleImageWithTitleType:YHTitleTypeBattle_title titleImageView:self.titleImgView];
}

///1.加载照片的日期数据
- (void)getDaysList{
    [self getDaysListWithSuccess:^(id responseObj) {
        self.daysListM = [YHGetDaysListResult mj_objectWithKeyValues:responseObj];
        if (self.daysListM.success.integerValue == 1) {//成功得到日期
            if (self.daysListM.days.count == 0) {
                [MBProgressHUD showError:@"您还没有上传过图片"];
                return ;
            }
            
            [self shiftPicAction:nil];
        }else{
            [MBProgressHUD showError:self.daysListM.messages];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

///加载到imgList之后的操作
- (void)setupAfterLoadImgList{
    
    [super setupAfterLoadImgList];
    //0.分数
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", self.ImgListM.score.floatValue];
    
    //1.设置显示日期
    NSString *date = self.daysListM.days[self.dayIndex];
    NSString *toShowDateStr = [[YHDateTool shareDateTool] convertToSpecifiedDateWithDateString:date FromDateFormate:@"yyyyMMdd" toDateFormate:@"yyyy-MM-dd"];
    [self.dateBtn setNormalTitle:toShowDateStr];
    //2.赞数量
    self.zanCountLabel.text = [NSString stringWithFormat:@"%zd个赞,其中%zd个vip赞", self.ImgListM.totalZan.integerValue, self.ImgListM.vipZan.integerValue];
    //3.根据url下载文件
    [self.collectionView reloadData];
}

#pragma mark ------------------------------------------
#pragma mark network method
///2.从网络加载指定日期下的图片
-(void)getSpecifiedDayPic:(NSString *)date{
    
    NSDictionary *paramDic = [self setupParamForImgListWithDate:date];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetImgList params:paramDic success:^(id  _Nonnull responseObj) {
        
        self.ImgListM = [YHGetImgListResult mj_objectWithKeyValues:responseObj];
        if (self.ImgListM.success.integerValue == 1) {
            
            [self setupAfterLoadImgList];
            
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@", self.ImgListM.message]];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    [self backToLastVc];
}

///切换不同日期图片,左按钮tag是10;右按钮tag是11
- (IBAction)shiftPicAction:(UIButton *)sender {
    
    ///提醒用户切换的日期有无图片
    BOOL isHaveImg = [self isHavePicWithShiftBtn:sender];
    if (!isHaveImg) {
        return;
    }
    
    //1.加载图片
    NSString *dateString = self.daysListM.days[self.dayIndex];
    [self getSpecifiedDayPic:dateString];
}

- (IBAction)seeCmtsAction:(UIButton *)sender {
    [self seeCmtsAction];
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
    
    YHSeeUploadGridImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHSeeUploadGridImgCell identifier] forIndexPath:indexPath];
    cell.delegate = self;
    cell.stopLoadImage = YES;//先停止下载
    
    NSString *stringUrl = nil;
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            
            //1.先从自己保存的图片中取
            stringUrl = self.ImgListM.store1Img1.imgUrl;
        }else if (indexPath.item == 1) {
            stringUrl = self.ImgListM.store1Img2.imgUrl;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.item == 0) {
            stringUrl = self.ImgListM.store2Img1.imgUrl;
        }else if (indexPath.item == 1) {
            stringUrl = self.ImgListM.store2Img2.imgUrl;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.item == 0) {
            stringUrl = self.ImgListM.store3Img1.imgUrl;
        }else if (indexPath.item == 1) {
            stringUrl = self.ImgListM.store3Img2.imgUrl;
        }
    }
    [self setCellImage:cell stringUrl:stringUrl];
    return cell;
}

- (void)setCellImage:(YHSeeUploadGridImgCell *)cell stringUrl:(NSString *)url{
    
    if (!url) {
        cell.picImgView.image = nil;
        return;
    }
    YHPopAllScreenImageView *imageView = (YHPopAllScreenImageView *)cell.picImgView;
    UIImage *savedImage = self.imagesDic[url];
    if (savedImage) {
        
        imageView.image = savedImage;
        //隐藏hiddenProgressView,防止上一轮图片没有下载成功,会在当前imageV显示.
        imageView.hiddenProgressView = YES;
    }else{
        cell.imgUrl = url;
    }
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
#pragma mark YHSeeUploadGridImagesCellDelegate
- (void)gridImagesCell:(YHGridImagesCell *)cell didFinishDownloadImage:(UIImage *)image imageStringUrl:(NSString *)stringUrl{
    
    self.imagesDic[stringUrl] = image;
}

#pragma mark ------------------------------------------
#pragma mark 实现父类方法
- (YHCategoryType)categoryType{
    return YHCategoryTypeBattleGridImages;
}



@end
