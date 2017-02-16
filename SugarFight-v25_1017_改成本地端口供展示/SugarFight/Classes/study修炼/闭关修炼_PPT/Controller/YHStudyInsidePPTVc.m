//
//  YHStudyInsideVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHStudyInsidePPTVc.h"
#import "YHStudyInsideExerciseVc.h"
#import "YHStudyInsidePPTCell.h"
#import "YHGetCourseImagesParam.h"
#import "YHGetCourseImagesResult.h"
#import "YHStudyCmptedParam.h"

static NSString *YHStrUrlGetCourseImages = @"jianpai/Study/getCourseImgs";
static NSString *YHStrUrlStudyCmpted = @"jianpai/Study/studyComplete";

@interface YHStudyInsidePPTVc ()<UICollectionViewDataSource, UICollectionViewDelegate, YHStudyInsidePPTCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** YHGetCourseImagesResult */
@property (nonatomic, strong) YHGetCourseImagesResult *imagesResult;
/** 课程索引,如:1/9 */
@property (weak, nonatomic) IBOutlet UILabel *pptNoticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *exerciseBtn;

@end

@implementation YHStudyInsidePPTVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self loadCourseImages];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.collectionView.yh_width, self.collectionView.yh_height);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)setup{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor clearColor]; 
    [self.collectionView registerClass:[YHStudyInsidePPTCell class] forCellWithReuseIdentifier:[YHStudyInsidePPTCell identifier]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

- (void)setupAfterGetCourseImages{
    
    self.exerciseBtn.enabled = YES;
    [self.collectionView reloadData];
    if (self.imagesResult.courseImgs.count > 0) {
        self.pptNoticeLabel.text = [NSString stringWithFormat:@"1/%zd", self.imagesResult.courseImgs.count];
    }
}

- (void)setupAfterIdel{
    NSInteger index = self.collectionView.contentOffset.x / self.collectionView.yh_width;
    self.pptNoticeLabel.text = [NSString stringWithFormat:@"%zd/%zd",index + 1 ,self.imagesResult.courseImgs.count];
    
    if ((index + 1) == self.imagesResult.courseImgs.count) {
        [self studyComplted];
    }
}

#pragma mark ------------------------------------------
#pragma mark network method
- (void)loadCourseImages{
    YHGetCourseImagesParam *param = [[YHGetCourseImagesParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.courseId = self.courseId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetCourseImages params:paramDic success:^(id  _Nonnull responseObj) {
        
        self.imagesResult = [YHGetCourseImagesResult mj_objectWithKeyValues:responseObj];
        if (self.imagesResult.status.integerValue == 1) {
            [self setupAfterGetCourseImages];
        }else{
            [MBProgressHUD showError:self.imagesResult.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (void)studyComplted{
    YHStudyCmptedParam *param = [[YHStudyCmptedParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.courseId = self.imagesResult.courseId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlStudyCmpted params:paramDic success:^(id  _Nonnull responseObj) {
        
        YHBaseModel *model = [YHBaseModel mj_objectWithKeyValues:responseObj];
        if (model.status.integerValue != 1) {
            [MBProgressHUD showError:model.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)exerciseAction:(UIButton *)sender {
    
    YHStudyInsideExerciseVc *exerciseVc = [[GlobeSingle shareGlobeSingle]vcWithSbName:NSStringFromClass([YHStudyInsideExerciseVc class])];
    exerciseVc.courseId = self.imagesResult.courseId;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:exerciseVc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

#pragma mark ------------------------------------------
#pragma mark UICollectionView data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesResult.courseImgs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHStudyInsidePPTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHStudyInsidePPTCell identifier] forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.stringUrl = self.imagesResult.courseImgs[indexPath.row];
    cell.shiftCell = YES;
    return cell;
}

#pragma mark ------------------------------------------
#pragma mark UICollectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark ------------------------------------------
#pragma mark UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setupAfterIdel];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView{
    [self setupAfterIdel];
}

#pragma mark ------------------------------------------
#pragma mark YHStudyInsidePPTCellDelegate
- (void)studyInsidePPTCell:(YHStudyInsidePPTCell *)cell DidFinishDownloadImage:(UIImage *)image imageUrl:(NSString *)stringUrl{
    
}

@end
