//
//  YHHelpButton.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHHelpButton.h"
#import "YHHelpDesView.h"
#import "YHHelpInfoResult.h"
#import "YHHelpInfoParam.h"
#import "YHShowGuideParam.h"
#import "YHShowGuideResult.h"
#import "YHPagerView.h"
#import "YHDownloadImageView.h"
#import "YHCircleButton.h"

static NSString *const YHStrUrlGetHelp = @"jianpai/Msg/getHelpImg";
static NSString *const YHStrUrlHelpInfo = @"jianpai/Msg/getHelpMsg";
static CGFloat const YHMarginOfCfmBtnToBottom = 20;

@interface YHHelpButton()<YHPagerViewDelegate>

/** YHHelpDesView,弱引用,因为其作为YHHelpView的一部分,YHHelpView是添加到window中 */
@property (nonatomic, weak) YHHelpDesView *helpDesView;
/** YHHelpInfoResult */
@property (nonatomic, strong) YHHelpInfoResult *helpInfoResult;
/** YHShowGuideResult 模型,引导图片 */
@property (nonatomic, strong) YHShowGuideResult *showGuideResult;
/** 帮助引导的图片 */
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableDictionary *imageDic;
/** pagerView */
@property (nonatomic, weak) YHPagerView *pagerView;

@end

@implementation YHHelpButton

- (YHHelpDesView *)helpDesView{
    if (!_helpDesView) {
        YHHelpDesView *helpDesView = [YHHelpDesView helpDesView];
        self.helpDesView = helpDesView;
        
    }
    return _helpDesView;
}

- (NSMutableDictionary *)imageDic{
    if (!_imageDic) {
        self.imageDic = [[NSMutableDictionary alloc] init];
    }
    return _imageDic;
}

- (void)awakeFromNib{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setNormalImage:@"helpOfGame"];
    
}

- (void)setupAfterGetGuideImages{
    
    //如果得到的图片数量为0,就不显示图片引导页了
    if (self.showGuideResult.helpImgs.count == 0) {
        [self loadDesc];
    }
    
    //如果YHShowHelpImagesTypeAlways或show==1表示,显示图片引导页
    if (self.showHelpImages == YHShowHelpImagesTypeAlways ||self.showGuideResult.show.integerValue == 1) {
        
        [self showHelpGuideImages];
    }else{
        [self loadDesc];
    }
}

///显示帮助图片
- (void)showHelpGuideImages{
    CGRect rect = [UIScreen mainScreen].bounds;
    YHPagerView *pv = [[YHPagerView alloc] initWithFrame:rect];
    self.pagerView = pv;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:pv];
    pv.backgroundColor = [UIColor blackColor];
    pv.delegate = self;
    
    NSInteger count = self.showGuideResult.helpImgs.count;
    self.imageViews = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        YHDownloadImageView *imageView = [[YHDownloadImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        if (i == 0) {
            [self setImageForImageView:imageView imageViewIndex:i];
        }
        [self.imageViews addObject:imageView];
    }
    pv.showViews = self.imageViews;
}

- (void)setImageForImageView:(YHDownloadImageView *)imageView imageViewIndex:(NSInteger)index{
    
    NSString *url = self.showGuideResult.helpImgs[index];
    if (self.imageDic[url]) {
        imageView.image = self.imageDic[url];
    }else{
        
        [imageView yh_setImageWithUrl:url completed:^(UIImage *image, NSError *error) {
            if (image) {
                self.imageDic[url] = image;
            }else{
                [MBProgressHUD showError:@"请检查网络,稍后重试."];
                YHLog(@"error = %@", error);
            }
        }];
    }
}

#pragma mark ------------------------------------------
#pragma mark network method
- (void)loadDesc{
    
    NSDictionary *paramDic = [_paramOfHelpInfo mj_keyValues];
    [SVProgressHUD showWithStatus:nil];
    
    //先展示,让用户看到,再赋值
    [self.helpDesView show];
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlHelpInfo params:paramDic success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        self.helpInfoResult = [YHHelpInfoResult mj_objectWithKeyValues:responseObj];
        if (self.helpInfoResult.status.integerValue == 1) {
            self.helpDesView.helpInfoResult = self.helpInfoResult;
            
        }else{
            [MBProgressHUD showError:self.helpInfoResult.message];
            [self.helpDesView dismiss];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.helpDesView dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

//请求是否显示引导页
- (void)showGuide{
    YHShowGuideParam *param = [[YHShowGuideParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.category = YHCategoryTypeBattleGridImages;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetHelp params:paramDic success:^(id  _Nonnull responseObj) {
        
        self.showGuideResult = [YHShowGuideResult mj_objectWithKeyValues:responseObj];
        if (self.showGuideResult.status.integerValue == 1) {
            [self setupAfterGetGuideImages];
        }else{
            [MBProgressHUD showError:self.showGuideResult.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark public method
- (void)setShowHelpImages:(YHShowHelpImagesType)showHelpImages{
    _showHelpImages = showHelpImages;
    switch (showHelpImages) {
        case YHShowHelpImagesTypeAlways:{
            [self showHelpGuideImages];
        }
            
            break;
        case YHShowHelpImagesTypeLetsSee:{
            [self showGuide];
        }
            
            break;
        case YHShowHelpImagesTypeNo:{
            [self loadDesc];
        }
            
            break;
            
        default:
            break;
    }
}
//- (void)clickWithShowHelp:(BOOL)isShowHelp{
//    if (isShowHelp) {
//        [self showGuide];
//    }else{//不需要显示引导页
//        [self loadDesc];
//    }
//}

#pragma mark ------------------------------------------
#pragma mark YHPagerViewDelegate
- (void)pagerView:(YHPagerView *)pagerView didTurnToPagerIndex:(NSInteger)pagerIndex{
    YHDownloadImageView *imageView = self.imageViews[pagerIndex];
    [self setImageForImageView:imageView imageViewIndex:pagerIndex];
}

- (UIButton *)pagerViewShouldHaveFinishBtnAtLastIndexPath:(YHPagerView *)pagerView{
    YHCircleButton *btn = [YHCircleButton buttonWithType:UIButtonTypeCustom];
    [btn setNormalTitle:@"确定"];
    [btn setTitleColor:YHAppleBlue forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.layer.cornerRadius = 10;
    
    //73:34
    CGFloat btnW = 100.0f;
    CGFloat btnH = btnW * 34/73;
    CGFloat btnX = (YHScreenW - btnW) * 0.5;
    CGFloat btnY = YHScreenH - btnH - YHMarginOfCfmBtnToBottom;
    
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    return btn;
}

- (void)pagerViewDidClickFinishBtn:(YHPagerView *)pagerView{
    [pagerView removeFromSuperview];
    [self loadDesc];
}

- (void)pagerViewDidFinishTurnOverAllPages:(YHPagerView *)pagerView{
    [UIView animateWithDuration:2 animations:^{
//        pagerView.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
        pagerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [pagerView removeFromSuperview];
        [self loadDesc];
    }];
}

@end
