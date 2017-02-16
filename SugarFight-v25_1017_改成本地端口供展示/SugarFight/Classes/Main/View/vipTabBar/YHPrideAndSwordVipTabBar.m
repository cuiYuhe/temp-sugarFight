//
//  YHPrideAndSwordTabBar.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPrideAndSwordVipTabBar.h"
#import "YHFindErrorVC.h"
#import "YHChooseTFVC.h"
#import "YHCommonDataTool.h"
#import "YHSwordSongVc.h"
#import "YHPrizeListVc.h" //抽奖列表
#import "YHStudyListVc.h"

///本p,总计,切换btn的上部超出当前父控件的大小
static CGFloat const YHMarginBeyondOfPChooseBtn = 10.0f;
///tabBar的按钮的数量
static NSInteger const YHTabBarBtnCount = 4;

typedef NS_ENUM(NSInteger, YHGameBtnType) {
    YHGameBtnTypePrideFindError,
//    YHGameBtnTypeSwordChooseTF,
    YHGameBtnTypeSwordSongVc,
    YHGameBtnTypeStudy,
    ///抽奖
    YHGameBtnTypeDraw,
};

@interface YHPrideAndSwordVipTabBar()
/** bgImgv */
@property (nonatomic, weak) UIImageView *bgImgV;
/** 笑傲btn */
@property (nonatomic, weak) UIButton *btnPride;
/** 论剑btn */
@property (nonatomic, weak) UIButton *btnSword;

/** 修炼btn */
@property (nonatomic, weak) UIButton *studyBtn;
/** 本p\总计btn */
@property (nonatomic, weak) UIButton *pChooseBtn;
/** 抽奖按钮 */
@property (nonatomic, weak) UIButton *drawBtn;
@end

@implementation YHPrideAndSwordVipTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"bg_bottom"];
    [self addSubview:iv];
    self.bgImgV = iv;
    
    //1.本p\总计btn
    UIButton *pChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:pChooseBtn];
    self.pChooseBtn = pChooseBtn;
    [pChooseBtn setNormalBackgroundImage:@"benp_bt_arc"];
    [pChooseBtn setSelectedBackgoundImage:@"leiji_bt_arc"];
    [pChooseBtn addTarget:self action:@selector(pChooseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.其它两个btn
    UIButton *btPride = [UIButton buttonWithType:UIButtonTypeCustom];
    [btPride setNormalImage:@"xiaoao"];
    [btPride addTarget:self action:@selector(tabBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btnPride = btPride;
    btPride.tag = 10;
    [self addSubview:btPride];
    
    UIButton *btSword = [UIButton buttonWithType:UIButtonTypeCustom];
    [btSword setNormalImage:@"lunjian"];
    [btSword addTarget:self action:@selector(tabBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btnSword = btSword;
    btSword.tag = 11;
    [self addSubview:btSword];
    
    //3.修炼btn
    UIButton *studyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [studyBtn setNormalImage:@"xiulian"];
    [studyBtn addTarget:self action:@selector(tabBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.studyBtn = studyBtn;
    studyBtn.tag = 12;
    [self addSubview:studyBtn];
    
    //4.抽奖btn
    UIButton *drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [drawBtn setNormalImage:@"choujiang"];
    [drawBtn addTarget:self action:@selector(tabBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.drawBtn = drawBtn;
    drawBtn.tag = 13;
    [self addSubview:drawBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImgV.frame = self.bounds;
    
    //1.本p\总计btn
    CGFloat pChooseBtnX = 0;
    CGFloat pChooseBtnY = -YHMarginBeyondOfPChooseBtn;
    CGFloat pChooseBtnH = self.yh_height - pChooseBtnY;
    CGFloat pChooseBtnW = pChooseBtnH;
    self.pChooseBtn.frame = CGRectMake(pChooseBtnX, pChooseBtnY, pChooseBtnW, pChooseBtnH);
    
    //2.其它两个btn
    CGFloat marginTop = 5;
    CGFloat marginLeft = 10;
    
    CGFloat width = (self.yh_width - CGRectGetMaxX(self.pChooseBtn.frame) - marginLeft) / YHTabBarBtnCount;
    CGFloat height = self.yh_height;
    
    CGFloat prideX = CGRectGetMaxX(self.pChooseBtn.frame) + marginLeft;
    CGFloat prideY = marginTop;
    CGFloat prideW = width;
    CGFloat prideH = height;
    self.btnPride.frame = CGRectMake(prideX, prideY, prideW, prideH);
    
    CGFloat swordX = CGRectGetMaxX(self.btnPride.frame);
    CGFloat swordY = marginTop;
    CGFloat swordW = width;
    CGFloat swordH = height;
    self.btnSword.frame = CGRectMake(swordX, swordY, swordW, swordH);
    
    //3.修炼btn
    CGFloat studyX = CGRectGetMaxX(self.btnSword.frame);
    CGFloat studyY = marginTop;
    CGFloat studyW = width;
    CGFloat studyH = height;
    self.studyBtn.frame = CGRectMake(studyX, studyY, studyW, studyH);
    
    //4.抽奖按钮
    CGFloat drawBtnX = CGRectGetMaxX(self.studyBtn.frame);
    CGFloat drawBtnY = marginTop;
    CGFloat drawBtnW = width;
    CGFloat drawBtnH = height;
    self.drawBtn.frame = CGRectMake(drawBtnX, drawBtnY, drawBtnW, drawBtnH);
}

#pragma mark ------------------------------------------
#pragma mark external method
+ (YHPrideAndSwordVipTabBar *)prideAndSwordVipTabBar{
    YHPrideAndSwordVipTabBar *tabBar = [[self alloc] init];
    return tabBar;
}

#pragma mark ------------------------------------------
#pragma mark events
//笑傲,论剑, 抽奖.tag分别为10,11,12
- (void)tabBarBtnAction:(UIButton *)sender {
    NSInteger btnIndex = sender.tag - 10;
    UIViewController *vc = nil;
    switch (btnIndex) {
        case YHGameBtnTypePrideFindError:{
            vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHFindErrorVC class])];
        }
            break;
        case YHGameBtnTypeSwordSongVc:{
            vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHSwordSongVc class])];
        }
            break;
        case YHGameBtnTypeStudy:{
            vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHStudyListVc class])];
        }
            break;
            
        case YHGameBtnTypeDraw:{
            vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHPrizeListVc class])];
        }
            break;
            
        default:
            break;
    }
    
    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    UIViewController *topVc = [UIViewController yh_getTopVc];
    [UIViewController yh_ModalVcWithSourceVc:topVc destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

///默认本p; selected为累计
- (void)pChooseBtnClicked:(UIButton *)pChooseBtn{
    pChooseBtn.selected = !pChooseBtn.selected;
    
    YHPType p;
    if (pChooseBtn.selected) {//selected时为累计
        p = YHPTypeTotal;
    }else{
        p = YHPTypeThisP;
    }
    NSString *pChosen = [[YHCommonDataTool shareCommonDataTool] getSelectPWithpType:p];
    if ([self.delegate respondsToSelector:@selector(prideAndSwordTabBarDidShiftP:thisPOrTotal:)]) {
        [self.delegate prideAndSwordTabBarDidShiftP:self thisPOrTotal:pChosen];
    }
}

@end
