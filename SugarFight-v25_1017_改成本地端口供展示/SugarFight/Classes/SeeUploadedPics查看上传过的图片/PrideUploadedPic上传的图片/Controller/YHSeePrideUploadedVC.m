//
//  YHPrideUploadedPicVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/1.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSeePrideUploadedVC.h"
#import <SDWebImageDownloader.h>
#import "YHGetImgListParam.h"
#import "YHCommentsListParam.h"

static NSString *const YHStrUrlGetImgList = @"jianpai/Msg/getImgList";

@interface YHSeePrideUploadedVC ()
/** 分数 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/** 日期 */
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
/** 上面的imageView */
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *upImgView;
/** 下面的imageView */
@property (weak, nonatomic) IBOutlet YHPopAllScreenImageView *downImgView;
/** 赞的数量, 100个赞,其中30个vip赞 */
@property (weak, nonatomic) IBOutlet UILabel *zanCountLabel;
/** title文字 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;

@end

@implementation YHSeePrideUploadedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    //1.加载照片的日期数据,并加载图片
    [self getDaysList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.upImgView stopDownLoadImage];
    [self.downImgView stopDownLoadImage];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)setup{
    NSString *today = [[YHDateTool shareDateTool] getDateStringWithFullDateFormat:@"yyyy-MM-dd" date:[NSDate date]];
    [self.dateBtn setNormalTitle:today];
    
    //title文字
    YHTitlesResult *titlesM = [GlobeSingle shareGlobeSingle].titlesM;
    [titlesM setTitleImageWithTitleType:YHTitleTypeBcr_title titleImageView:self.titleImgView];
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
    YHGetImageModel *imageM0 = self.ImgListM.imgs.firstObject;
    YHGetImageModel *imageM1 = self.ImgListM.imgs.lastObject;
    [self setImageToImgView:imageM0.imgUrl imageViewToSet:self.upImgView];
    [self setImageToImgView:imageM1.imgUrl imageViewToSet:self.downImgView];
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
#pragma mark events
- (IBAction)backAction:(UIButton *)sender {
    [self backToLastVc];
}

///切换不同日期图片,左按钮tag是10;右按钮tag是11
- (IBAction)shiftPicAction:(UIButton *)sender {
    
    [self.downImgView stopDownLoadImage];
    [self.upImgView stopDownLoadImage];
    
    ///提醒用户切换的日期有无图片
    BOOL isHaveImg = [self isHavePicWithShiftBtn:sender];
    if (!isHaveImg) {
        return;
    }
    
    //1.加载图片
    NSString *dateString = self.daysListM.days[self.dayIndex];
    [self getSpecifiedDayPic:dateString];
}
- (IBAction)seeComments:(UIButton *)sender {
    
    [self seeCmtsAction];
    
}

#pragma mark ------------------------------------------
#pragma mark 实现父类方法
- (YHCategoryType)categoryType{
    return YHCategoryTypePrideBcr;
}

@end
