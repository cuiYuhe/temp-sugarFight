//
//  YHLoginOffVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHLoginOffVC.h"
#import "YHLoginField.h"
#import "YHChangePwdVC.h"
#import "YHChangeIconVC.h"
#import "YHGetUserAvatarParam.h"
#import "YHGetUserAvatarResult.h"
#import <UIButton+WebCache.h>
#import "YHSugarFightWSVC.h"
#import "YHSugarFightNotWSVC.h"
#import "YHLoginVC.h"
#import "YHAlertController.h"
#import "YHRealScoreDetailModel.h"

static NSString *const strUrlAvatar = @"jianpai/User/getMyava";

@interface YHLoginOffVC ()<UITextFieldDelegate>
/** 战斗力指数,箭旁边的label */
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
/** 笑傲江湖label */
@property (weak, nonatomic) IBOutlet UIButton *prideScoreBtn;
/** 华山论剑 label */
@property (weak, nonatomic) IBOutlet UIButton *huaShanScoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *trainScoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIImageView *signInScoreLabel;
/** 全部用的field,没什么优化,应该用cell */
@property (weak, nonatomic) IBOutlet YHLoginField *accountField;
@property (weak, nonatomic) IBOutlet YHLoginField *pwdField;
@property (weak, nonatomic) IBOutlet YHLoginField *districtField;
@property (weak, nonatomic) IBOutlet YHLoginField *sourceField;
@property (weak, nonatomic) IBOutlet YHLoginField *telField;
/** YHGetUserAvatarResult */
@property (nonatomic, strong) YHGetUserAvatarResult *userAvatarResultM;
/** 上部的头像 */
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
/** 包装笑傲江湖信息的view */
@property (weak, nonatomic) IBOutlet UIView *prideAuxiliaryView;

@end

@implementation YHLoginOffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //setup方法中要得到presentingVc,所以在此方法中
    [self setup];
    
    //当更改头像后,回来要重新获得头像,此时是dismiss,不会调用viewDidLoad
    [self getAvatar];
    
}

#pragma mark ------------------------------------------
#pragma mark initialise
- (void)setup{
    //当点击此field时,需要中转界面
    self.pwdField.delegate = self;
    
    YHLoginModel *loginM = [GlobeSingle shareGlobeSingle].loginM;
    //赋值
    YHLoginDataUserModel *userM = loginM.data.user;
    self.districtField.text = loginM.userArea;
    self.accountField.text = userM.userName;
    self.pwdField.text = userM.userPwd;
    self.sourceField.text = loginM.userWay;
    self.telField.text = userM.userTel;
    
    //直接在set方法中不可以,因为当前控件都还没有创建
    YHScoreDetailModel *scoreDetailM = self.realScoreDetailM.scoreDetail;
    NSString *bcrScore = [NSString stringWithFormat:@"%.1f", scoreDetailM.brcScore.floatValue];
    [self.prideScoreBtn setTitle:bcrScore forState:UIControlStateNormal];
    [self.huaShanScoreBtn setNormalTitle:[NSString stringWithFormat:@"%.1f", scoreDetailM.preScore.floatValue]];
    [self.signInBtn setNormalTitle:[NSString stringWithFormat:@"%.1f", scoreDetailM.signScore.floatValue]];

    self.totalScoreLabel.text = [NSString stringWithFormat:@"%.1f", scoreDetailM.totalScore.floatValue];
    self.totalScoreLabel.font = YHFontFZHuangCao(25);
    
    
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)getAvatar{
    YHGetUserAvatarParam *param = [[YHGetUserAvatarParam alloc] init];
    YHLoginModel *loginM = [GlobeSingle shareGlobeSingle].loginM;
    param.uid = loginM.data.user.userId;
    param.token = [GlobeSingle shareGlobeSingle].uuid;
    NSNumber *userAvatarId = loginM.data.user.userAvatarId;
    param.userAvatarId = userAvatarId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:strUrlAvatar params:paramDic success:^(id  _Nonnull responseObj) {
        self.userAvatarResultM = [YHGetUserAvatarResult mj_objectWithKeyValues:responseObj];
        [self setupAfterLoadAvatar];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (void)setupAfterLoadAvatar{
    
    YHGetUserAvatarResultSubRef *ref = self.userAvatarResultM.ref;
    NSString *strUrl = ref.refValue;
    NSURL *url = [NSURL URLWithString:strUrl];
    [self.avatarBtn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
}

- (void)cfmToLogOff{
    //1.清空个人信息,头像接口以后要更改成即时改变.不然太乱.
//    [GlobeSingle shareGlobeSingle].changedAvatar = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YHUsernameKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YHPwdKey];
    //2.切换到loginVc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YHLoginVC *vc = [sb instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setRealScoreDetailM:(YHRealScoreDetailModel *)realScoreDetailM{
    _realScoreDetailM = realScoreDetailM;
    
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)logOffAction:(id)sender {
    YHFunc
    WeakSelf
    if (YHiosVersion(8.0)) {
    
        YHAlertController *alertVc = [YHAlertController alertWithDoubleActionsTitle:@"确定要注销吗?" message:@"注销后将删除您的个人信息." cfmBlock:^{
            [weakSelf cfmToLogOff];
        }];
        [self presentViewController:alertVc animated:YES completion:nil];
    }else{
        [self cfmToLogOff];
    }

}
- (IBAction)iconAction:(id)sender {
    YHFunc
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHChangeIconVC class]) bundle:nil];
    YHChangeIconVC *vc = [sb instantiateInitialViewController];
    vc.avatarUrlString = self.userAvatarResultM.ref.refValue;
    
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}
- (IBAction)backAction:(UIButton *)sender {
    //1.第一次登录是从修改密码vc而来,则返回到相应的主界面
    if ([self.presentingViewController isKindOfClass:[YHChangePwdVC class]]) {

        UIViewController *vc = [[GlobeSingle shareGlobeSingle] findWhatUserType];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ------------------------------------------
#pragma mark UITextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHChangePwdVC class]) bundle:nil];
    YHChangePwdVC *vc = [sb instantiateInitialViewController];
    //判断自己是不是被将显示的vc,modal出来.
//    if ([self.presentingViewController isKindOfClass:[YHChangePwdVC class]]){//是就dissmiss
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }else{ //不是就modal
//        [self presentViewController:vc animated:NO completion:nil];
//    }
    
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:vc presentAnimated:NO dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}

@end
