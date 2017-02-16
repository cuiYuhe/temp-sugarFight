//
//  YHSeeHuaShanUploadedVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSeeHuaShanUploadedVC.h"
#import <SDWebImageDownloader.h>
#import "YHGetImgListParam.h"
#import "YHGetImgListResult.h"
#import "YHCommentModel.h"
#import "YHCommentsListParam.h"
#import "YHPopAllScreenImageView.h"

static NSString *const YHStrUrlGetImgList = @"jianpai/Msg/getImgList";

@interface YHSeeHuaShanUploadedVC ()
/** 分数 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/** 日期 */
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
/** 赞的数量, 100个赞,其中30个vip赞 */
@property (weak, nonatomic) IBOutlet UILabel *zanCountLabel;
@property (weak, nonatomic) IBOutlet UIView *imgVsContainerView;

/** 上面的imgView */
@property (nonatomic, weak) YHPopAllScreenImageView *upImgView;
/** 中部的imgView */
@property (nonatomic, weak) YHPopAllScreenImageView *midImgView;
/** 下面的imgView */
@property (nonatomic, weak) YHPopAllScreenImageView *downImgView;

/** getSpecifiedDayPic 的上一个param */
@property (nonatomic, strong) NSDictionary *lastParamOfGetPic;

@end

@implementation YHSeeHuaShanUploadedVC
- (UIImageView *)upImgView{
    if (!_upImgView) {
        YHPopAllScreenImageView *iv = [YHPopAllScreenImageView popAllScreenImageView];
        [self.imgVsContainerView addSubview:iv];
        [self setupUploadImageView:iv];
        _upImgView = iv;
    }
    return _upImgView;
}
- (UIImageView *)midImgView{
    if (!_midImgView) {
        YHPopAllScreenImageView *iv = [YHPopAllScreenImageView popAllScreenImageView];
        [self.imgVsContainerView addSubview:iv];
        [self setupUploadImageView:iv];
        _midImgView = iv;
    }
    return _midImgView;
}
- (UIImageView *)downImgView{
    if (!_downImgView) {
        YHPopAllScreenImageView *iv = [YHPopAllScreenImageView popAllScreenImageView];
        [self.imgVsContainerView addSubview:iv];
        [self setupUploadImageView:iv];
        _downImgView = iv;
    }
    return _downImgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //1.加载照片的日期数据
    [self getDaysList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.upImgView stopDownLoadImage];
    [self.midImgView stopDownLoadImage];
    [self.downImgView stopDownLoadImage];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)setup{
    NSString *today = [[YHDateTool shareDateTool] getDateStringWithFullDateFormat:@"yyyy-MM-dd" date:[NSDate date]];
    [self.dateBtn setNormalTitle:today];
}

- (void)setupUploadImageView:(UIImageView *)imageView{
    imageView.backgroundColor = [UIColor grayColor];
    imageView.layer.borderColor = [UIColor yellowColor].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}

///根据urlString数量加载imageView的数量
- (void)setupImageViewsWithUrlStrings:(NSArray *)urlStrings{
    switch (urlStrings.count) {
        case 1:{
            [_midImgView removeFromSuperview];
            [_downImgView removeFromSuperview];
            self.upImgView.frame = self.imgVsContainerView.bounds;
            [self.imgVsContainerView addSubview:self.upImgView];
            [self setImageToImgView:urlStrings[0] imageViewToSet:self.upImgView];
        }
            break;
        case 2:{
            [_downImgView removeFromSuperview];
            CGFloat upX = 0;
            CGFloat upY = 0;
            CGFloat upW = self.imgVsContainerView.yh_width;
            CGFloat upH = self.imgVsContainerView.yh_height * 0.5;
            self.upImgView.frame = CGRectMake(upX, upY, upW, upH);
            [self.imgVsContainerView addSubview:self.upImgView];
            
            CGFloat midX = 0;
            CGFloat midY = CGRectGetMaxY(self.upImgView.frame);
            CGFloat midW = upW;
            CGFloat midH = self.imgVsContainerView.yh_height * 0.5;
            self.midImgView.frame = CGRectMake(midX, midY, midW, midH);
            [self.imgVsContainerView addSubview:self.midImgView];
            [self setImageToImgView:urlStrings[0] imageViewToSet:self.upImgView];
            [self setImageToImgView:urlStrings[1] imageViewToSet:self.midImgView];
        }
            break;
        case 3:{
            CGFloat upX = 0;
            CGFloat upY = 0;
            CGFloat upW = self.imgVsContainerView.yh_width;
            CGFloat upH = self.imgVsContainerView.yh_height * 1/3;
            self.upImgView.frame = CGRectMake(upX, upY, upW, upH);
            [self.imgVsContainerView addSubview:self.upImgView];
            
            CGFloat midX = 0;
            CGFloat midY = CGRectGetMaxY(self.upImgView.frame);
            CGFloat midW = self.imgVsContainerView.yh_width;
            CGFloat midH = upH;
            self.midImgView.frame = CGRectMake(midX, midY, midW, midH);
            [self.imgVsContainerView addSubview:self.midImgView];
            
            CGFloat downX = 0;
            CGFloat downY = CGRectGetMaxY(self.midImgView.frame);
            CGFloat downW = self.imgVsContainerView.yh_width;
            CGFloat downH = upH;
            self.downImgView.frame = CGRectMake(downX, downY, downW, downH);
            [self.imgVsContainerView addSubview:self.downImgView];
            
            [self setImageToImgView:urlStrings[0] imageViewToSet:self.upImgView];
            [self setImageToImgView:urlStrings[1] imageViewToSet:self.midImgView];
            [self setImageToImgView:urlStrings[2] imageViewToSet:self.downImgView];
        }
            break;
            
        default:
            break;
    }
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
    NSMutableArray *urlStrings = [NSMutableArray array];
    for (YHGetImageModel *model in self.ImgListM.imgs) {
        [urlStrings addObject:model.imgUrl];
    }
    [self setupImageViewsWithUrlStrings:urlStrings];
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

///2.从网络加载指定日期下的图片
-(void)getSpecifiedDayPic:(NSString *)date{
    
    NSDictionary *paramDic = [self setupParamForImgListWithDate:date];
    self.lastParamOfGetPic = paramDic;
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetImgList params:paramDic success:^(id  _Nonnull responseObj) {
        if (self.lastParamOfGetPic != paramDic) {
            return ;
        }
        
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
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self backToLastVc];
}

///切换不同日期图片,左按钮tag是10;右按钮tag是11
- (IBAction)shiftPicAction:(UIButton *)sender {
    
    //取消当前的下载图片操作
    [self.upImgView stopDownLoadImage];
    [self.midImgView stopDownLoadImage];
    [self.downImgView stopDownLoadImage];
    
    ///提醒用户切换的日期有无图片
    BOOL isHaveImg = [self isHavePicWithShiftBtn:sender];
    if (!isHaveImg) {
        return;
    }
    
    //1.加载图片
    NSString *dateString = self.daysListM.days[self.dayIndex];
    [self getSpecifiedDayPic:dateString];
}

- (IBAction)seeCommentAction:(UIButton *)sender {
    
    [self seeCmtsAction];
}

#pragma mark ------------------------------------------
#pragma mark 实现父类方法
- (YHCategoryType)categoryType{
    return YHCategoryTypeHuaShanPerfect;
}

@end
