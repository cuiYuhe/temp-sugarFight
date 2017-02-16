//
//  YHShaveDrawVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHShakeDrawVc.h"
#import "YHShakeView.h" //摇一摇箱子的view
#import "YHGiftSuccessView.h" //成功摇到礼品的view
#import "YHGiftFailView.h" //失败摇到礼品的view
#import "YHPrizeOwnerInfoVc.h"
#import "YHShakePrizeParam.h"
#import "YHShakePrizeResult.h"
#import "YHBaseParam.h"
#import "YHGetOwnerInfoResult.h"
#import <AudioToolbox/AudioToolbox.h>
#import "YHPopAlertView.h"

///抽奖,有没有中奖
static NSString *const YHStrUrlGetDrawResult = @"jianpai/lottery/userLottery";
///查询领奖收货信息
static NSString *const YHStrUrlGetOwnerInfo = @"jianpai/lottery/getReceiver";


@interface YHShakeDrawVc ()<YHGiftFailViewDelegate, YHGiftSuccessViewDelegate>

/** 摇一摇view */
@property (nonatomic, weak) YHShakeView *shakeView;

@property (weak, nonatomic) IBOutlet UIImageView *openBoxImageView;
/** 成功摇奖view */
@property (nonatomic, weak) YHGiftSuccessView *sucView;

/** 失败摇奖view */
@property (nonatomic, weak) YHGiftFailView *failView;
/** YHShakePrizeResult */
@property (nonatomic, strong) YHShakePrizeResult *shakePrizeRes;

@end

@implementation YHShakeDrawVc

- (void)viewDidLoad {
    [super viewDidLoad];

    ///设置摇一摇view
    [self setupShakeView];
    
    self.openBoxImageView.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //摇一摇
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    //成功抽奖后,修改收件人信息,重新赋值
    if (self.sucView && self.shakePrizeRes) {
        self.sucView.receiver = self.shakePrizeRes.receiver;
        if ([self.delegate respondsToSelector:@selector(shakeDrawVcDidChangePrizeOwnerInfo:changedInfo:)]) {
            [self.delegate shakeDrawVcDidChangePrizeOwnerInfo:self changedInfo:self.shakePrizeRes.receiver];
        }
    }
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //摇奖结果
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        
//        [self setupSucShakeView];
//        [self setupFailShakeView];
    } completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark ------------------------------------------
#pragma mark private method
///设置摇一摇view
- (void)setupShakeView{
    
    if (self.shakeView) { //已经创建
        self.shakeView.hidden = NO;
        return;
    }
    
    //未创建
    YHShakeView *shakeView = [YHShakeView viewFromXib];
    self.shakeView = shakeView;
    
    //30为下面label的高度
    shakeView.yh_size = CGSizeMake(220, 115 + 30);
    shakeView.center = self.view.center;
    [self.view addSubview:shakeView];
    
    //添加手势
    UITapGestureRecognizer *shakeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shake:)];
    [shakeView addGestureRecognizer:shakeGes];
}

///设置摇奖成功view
- (void)setupSucShakeView{
    
    //1.判断有没有添加过success view
    self.openBoxImageView.hidden = NO;
    if (self.sucView) { //已经创建
        self.sucView.hidden = NO;
        return;
    }
    
    //未创建
    YHGiftSuccessView *sucView = [YHGiftSuccessView viewFromXib];
    sucView.hidden = NO;
    self.sucView = sucView;
    [self.view addSubview:sucView];
    
//    YHGiftSuccessView *sucView = [YHGiftSuccessView viewFromXib];
    CGFloat sucViewX = 30;
    CGFloat sucViewY = 60;
    CGFloat sucViewH = CGRectGetMinY(self.openBoxImageView.frame) - sucViewY - 10;
    CGFloat sucViewW = YHScreenW - 2 * sucViewX;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.sucView.frame = CGRectMake(sucViewX, sucViewY, sucViewW, sucViewH);
    }];
    
    self.sucView.delegate = self;
    self.sucView = sucView;
    [self.view addSubview:sucView];
    
    //2.得到收货人信息
    YHBaseParam *param = [[YHBaseParam alloc] init];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetOwnerInfo params:[param mj_keyValues] success:^(id  _Nonnull responseObj) {
        
        YHGetOwnerInfoResult *infoRes = [YHGetOwnerInfoResult mj_objectWithKeyValues:responseObj];
        if (infoRes.status.integerValue == 1) {
            infoRes.receiver.giftName = self.shakePrizeRes.gift.name;
            self.sucView.receiver = infoRes.receiver;
        }else{
            [MBProgressHUD showError:infoRes.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

///设置摇奖失败view
- (void)setupFailShakeView{
    
    self.openBoxImageView.hidden = NO;
    if (self.failView) { //已经创建
        self.failView.hidden = NO;
        return;
    }
    
    //未创建
    YHGiftFailView *failView = [YHGiftFailView viewFromXib];
    CGFloat failViewH = 280;
    CGFloat failViewX = 50;
    CGFloat failViewY = CGRectGetMinY(self.openBoxImageView.frame) - failViewH - 10;
;
    CGFloat failViewW = YHScreenW - 2 * failViewX;
    
    [UIView animateWithDuration:0.5 animations:^{
        failView.frame = CGRectMake(failViewX, failViewY, failViewW, failViewH);
    }];
    
    failView.delegate = self;
    self.failView = failView;
    [self.view addSubview:failView];
}

///拿到摇奖后的操作
- (void)setupAfterShakedPrize{
    
    self.shakeView.hidden = YES;
    
    if (self.shakePrizeRes.lotteryStatus) {//中奖
        [self setupSucShakeView];
    }else{//未中奖
        
        [self setupFailShakeView];
    }
}

#pragma mark ------------------------------------------
#pragma mark 手势
- (void)shake:(UITapGestureRecognizer *)tapGes{
    
    [SVProgressHUD showWithStatus:nil];
    YHShakePrizeParam *param = [[YHShakePrizeParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.giftId = self.giftId;
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetDrawResult params:[param mj_keyValues] success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        self.shakePrizeRes = [YHShakePrizeResult mj_objectWithKeyValues:responseObj];
        if (self.shakePrizeRes.status.integerValue == 1) {
            [self setupAfterShakedPrize];
        }else{
            
            YHPopAlertView *alertView = [YHPopAlertView popAlertViewSingleBtnWithContent:self.shakePrizeRes.message cfm:nil];
            [alertView show];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    [self dismissVc];
}

#pragma mark ------------------------------------------
#pragma mark YHGiftFailViewDelegate
- (void)giftFailViewDidClickOnceMore:(YHGiftFailView *)failView{
    
    self.openBoxImageView.hidden = YES;
    self.failView.hidden = YES;
    [self setupShakeView];
    
}

#pragma mark ------------------------------------------
#pragma mark YHGiftSuccessViewDelegate
- (void)giftSuccessViewDidClickCfm:(YHGiftSuccessView *)sucView{
    YHFunc
    self.sucView.hidden = NO;
    [self dismissVc];
}

- (void)giftSuccessViewDidClickModify:(YHGiftSuccessView *)sucView{
    YHFunc
    YHPrizeOwnerInfoVc *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHPrizeOwnerInfoVc class])];
    vc.receiverM = self.shakePrizeRes.receiver;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

#pragma mark - ShakeToEdit 摇动手机之后的回调方法
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake){
        // your code
//        YHLog(@"begin animations");
    }
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //
//    YHLog(@"摇动取消");
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    //防止连续摇动调用,正好利用openBoxImageView.hidden
    if (self.openBoxImageView.hidden == NO) {
        return;
    }
    
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); //震动效果
        [self shake:nil];
    }
}

@end
