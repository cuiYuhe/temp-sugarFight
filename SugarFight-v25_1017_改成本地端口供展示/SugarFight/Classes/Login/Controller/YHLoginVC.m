//
//  YHLoginVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHLoginVC.h"
#import "YHLoginField.h"
#import "YHPopChangePwdView.h"
#import "YHPopLongNoSeeView.h"
#import "YHPopChangeScoreView.h"
#import "YHDateTool.h"
#import "YHSugarFightNotWSVC.h"
#import "YHSugarFightWSVC.h"
#import "YHLoginParam.h"
#import "YHLoginModel.h"
#import "YHTestBaseUrlView.h"
#import "JPUSHService.h"
#import "YHPushModel.h"
#import "YHCommentsListVC.h"
#import "YHPopAlertView.h"
#import "YHBaseParam.h"

/** 保存到偏好设置的key,表明是否是第一次登录 */
static NSString *const YHLastLoginDateKey = @"YHLastLoginDateKey";
/** 保存的日期格式 */
static NSString *const YHDateFormat = @"yyyyMMdd hhmmss";

static CGFloat const YHPopViewW = 265;
static CGFloat const YHPopViewH = 83;
static NSString *const YHLoginStrUrl = @"jianpai/User/login";

typedef NS_ENUM(NSInteger, YHPopViewType) {
    /** 第一次登录 */
    YHPopViewTypeFirst = 0,
    /** 3天内登录 */
    YHPopViewTypeWithIn3Ds,
    /** 3天以上登录 */
    YHPopViewTypeMoreThan3Ds,
};

@interface YHLoginVC ()<UITextFieldDelegate, YHPopLongNoSeeViewDelegate, YHPopChangeScoreViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet YHLoginField *accountField;
@property (weak, nonatomic) IBOutlet YHLoginField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/* 登陆时的菊花 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *chrysanthemum;
/** 正在编辑的textField */
@property (nonatomic, strong) UITextField *editingTxtFld;
/** account textField的上部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountFldTopCons;
/** field在y方向上的偏移量 */
@property (nonatomic, assign) CGFloat offsetYNeed;
/** field在y方向上的初始约束 */
@property (nonatomic, assign) CGFloat accountFldOriginaltop;
/** YHLoginModel */
@property (nonatomic, strong) YHLoginModel *loginM;

@end

@implementation YHLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化
    [self setup];
    
    
    //2.get saved info from sandbox
    NSString *savedUsername = [[NSUserDefaults standardUserDefaults] objectForKey:YHUsernameKey];
    NSString *savedPwd = [[NSUserDefaults standardUserDefaults] objectForKey: YHPwdKey];
    if (savedUsername.length == 0 || savedPwd.length == 0) {//如果为空
#if DEBUG
        //test
        self.accountField.text = @"ism002";
        self.pwdField.text = @"123456";
        
#endif
        return;
    }
    
#if DEBUG
    //测试环境下,不让自动登录,以切换网络
    
    self.accountField.text = savedUsername;
    self.pwdField.text = savedPwd;
    return;
#endif
    
    [self loginWithName:savedUsername pwd:savedPwd success:nil failed:nil];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ------------------------------------------
#pragma mark 初始化
- (void)setup{
    
#if DEBUG
    //测试使用的baseUrl
    //test
    YHTestBaseUrlView *urlView = [YHTestBaseUrlView testBaseUrlView];
    [self.view addSubview:urlView];
    urlView.yh_y = 10;
    //开发阶段为显示
    urlView.hidden = NO;
    
#endif
    
    //1.第一个field处于编辑,键盘升高,感觉有点突兀
//    [self.accountField becomeFirstResponder];
    //2.监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    //3.添加手势
    UITapGestureRecognizer *hidekeyboard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidekeyboard)];
    [self.view addGestureRecognizer:hidekeyboard];
    
    self.accountFldOriginaltop = self.accountFldTopCons.constant;
    //4.设置代理
    self.accountField.delegate = self;
    self.pwdField.delegate = self;
}

#pragma mark ------------------------------------------
#pragma mark private method


#pragma mark ------------------------------------------
#pragma mark network method
- (void)loginWithName:(NSString *)userName pwd:(NSString *)pwd success:(void(^)())sucess failed:(void(^)())failed{
    
    self.accountField.text = userName;
    self.pwdField.text = pwd;
    
    //2.get saved info from server
    [self.chrysanthemum startAnimating];
    self.loginBtn.enabled = NO;
    
    YHLoginParam *param = [[YHLoginParam alloc] init];
    param.userName = userName;
    param.userPwd = pwd;
    param.currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    param.platform = @"IOS";
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postByJSONDataWithUrl:YHLoginStrUrl params:paramDic success:^(id  _Nonnull responseObj) {
        
        [self.chrysanthemum stopAnimating];
        self.loginM = [YHLoginModel mj_objectWithKeyValues:responseObj];

        if (self.loginM.status.integerValue != 1) { //错误
            if (self.loginM.status.integerValue == 4) {
                //2.提示更新版本
                YHPopAlertView *pav = [YHPopAlertView popAlertViewSingleBtnWithContent:@"sorry亲!请更新至最新版本,否则不能使用本app!" cfm:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:YHAppAddressInAppStore]];
                }];
                [pav show];
                return ;
            }
            [MBProgressHUD showError:self.loginM.message];
            self.loginBtn.enabled = YES;
            
            return ;
        }
        [self setupAfterLoadWithName:userName pwd:pwd];
        //加载后数据的操作
        !sucess ? : sucess();
        
    } failure:^(NSError * _Nonnull error) {
        YHLog(@"error = %@", error);
        [MBProgressHUD showError:@"请检查网络并重试."];
        [self.chrysanthemum stopAnimating];
        self.loginBtn.enabled = YES;
        !failed ? : failed();
    }];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)loginAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    sender.enabled = NO;
    //1.check if info is null
    NSString *inputUsername = self.accountField.text;
    NSString *inputPwd = self.pwdField.text;
    if (!inputUsername.length || !inputPwd.length) {
        [MBProgressHUD showError:@"用户名或密码不能为空"];
        sender.enabled = YES;
        return;
    }
    
    [self loginWithName:inputUsername pwd:inputPwd success:^{
        sender.enabled = YES;
    } failed:^{
        sender.enabled = YES;
    }];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
//加载后数据的操作
- (void)setupAfterLoadWithName:(NSString *)userName pwd:(NSString *)pwd{
    
    //0.将多个界面使用的数据保存
    [GlobeSingle shareGlobeSingle].userID = self.loginM.data.user.userId;
    [GlobeSingle shareGlobeSingle].uuid = self.loginM.message;
    [GlobeSingle shareGlobeSingle].loginM = self.loginM;
    
    //1.将用户名密码保存到沙盒
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:YHUsernameKey];
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:YHPwdKey];
    //2.判断要弹出的view
    [self popView:self.loginM.loginStatus.integerValue];
    
    //推送:将uuid,token设置为alias
    NSString *alias = [NSString stringWithFormat:@"%@", self.loginM.data.user.userId];
    [JPUSHService setAlias:alias callbackSelector:nil object:nil];
}

///弹出相应的view
- (void)popView:(YHPopViewType)popViewType{
    
    if (popViewType == YHPopViewTypeFirst) { //没有保存的日期,第一次登录
        //1.弹出请修改密码提示框
        YHPopChangePwdView *changePwdView = [YHPopChangePwdView popChangePwdView];
        [self addPopView:changePwdView];
        
    }else if (popViewType == YHPopViewTypeWithIn3Ds){ //已经登录过
        if (self.loginM.vipLevel == YHVipLevelTypeCommon) {//普通用户
            YHPopChangeScoreView *scoreView = [YHPopChangeScoreView popChangeScoreView];
            scoreView.delegate = self;
            [self addPopView:scoreView];
        }else{//vip用户
            UIViewController *vc = [[GlobeSingle shareGlobeSingle]findWhatUserType];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        }
        
    }else if (popViewType == YHPopViewTypeMoreThan3Ds){ //未登录天数没有达到3天
        YHPopLongNoSeeView *seeView = [YHPopLongNoSeeView popLongNoSee];
        seeView.delegate = self;
        [self addPopView:seeView];
    }
}

- (void)addPopView:(UIView *)popView{
    self.maskView.hidden = NO;
    CGRect accountF = self.accountView.frame;
    CGFloat y = accountF.origin.y;
    CGFloat x = accountF.origin.x - (YHPopViewW - accountF.size.width) / 2;
    popView.frame = CGRectMake(x, y, YHPopViewW, YHPopViewH);
    [self.view addSubview:popView];

}

#pragma mark ------------------------------------------
#pragma mark 监听
-(void)keyboardWillShow:(NSNotification*)note
{
    CGRect keyboardF = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyH = keyboardF.size.height;
    
    //处于编辑状态的txtFld需要的移动量
    CGRect fieldF = [self.loginBtn convertRect:self.editingTxtFld.bounds toView:nil];
    CGFloat fieldMaxY = CGRectGetMaxY(fieldF);
    
    CGFloat margin = 50.0f;
    CGFloat offsetYNeed = fieldMaxY - (YHScreenH - keyH) + margin;
    self.offsetYNeed = offsetYNeed;
//    YHLog(@"offsetYNeed = %zd", offsetYNeed);
    //如果当前编辑的txtFld没有被键盘覆盖,则不需要偏移
    if (offsetYNeed < 0) {
        return;
    }
    
    self.accountFldTopCons.constant -= offsetYNeed;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }completion:nil];
    
}

-(void)keyboardWillhide:(NSNotification*)sender
{
    if (self.offsetYNeed < 0) {
        return;
    }
    self.accountFldTopCons.constant = self.accountFldOriginaltop;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }completion:nil];
}

-(void)hidekeyboard{
    
    [self.view endEditing:YES];
}

- (void)selectBaseUrl{
//    [self loginAction:nil];
    NSString *savedUsername = [[NSUserDefaults standardUserDefaults] objectForKey:YHUsernameKey];
    NSString *savedPwd = [[NSUserDefaults standardUserDefaults] objectForKey: YHPwdKey];
    if (savedUsername.length == 0 || savedPwd.length == 0) {//如果为空
        return;
    }
    [self loginWithName:savedUsername pwd:savedPwd success:nil failed:nil];
    
}

#pragma mark ------------------------------------------
#pragma mark UITextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //先执行这个代理方法,之后键盘才会弹出
    self.editingTxtFld = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.accountField) {
        [self.pwdField becomeFirstResponder];
        
    }else if (textField == self.pwdField){
        [self loginAction:nil];
    }
    return YES;
}

#pragma mark ------------------------------------------
#pragma mark YHPopLongNoSeeViewDelegate
- (void)popLongNoSeeViewDidClickCfm:(YHPopLongNoSeeView *)popView{
    
    BOOL isRemoteNote = [self checkRemoteNoteDestinVc];
    if (isRemoteNote) return;
    
    if (self.loginM.vipLevel == YHVipLevelTypeCommon) {//普通用户
        //好久不见view点击确定时,弹出scoreView
        YHPopChangeScoreView *scoreView = [YHPopChangeScoreView popChangeScoreView];
        scoreView.delegate = self;
        [self addPopView:scoreView];
    }else{//vip用户
        UIViewController *vc = [[GlobeSingle shareGlobeSingle] findWhatUserType];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    }
}

#pragma mark ------------------------------------------
#pragma mark YHPopChangeScoreViewDelegate
- (void)popChangeScoreViewDidClickCfm:(YHPopChangeScoreView *)popView{
    
    BOOL isRemoteNote = [self checkRemoteNoteDestinVc];
    if (isRemoteNote) return;
    
    UIStoryboard *sb = nil;
    if ([[GlobeSingle shareGlobeSingle].loginM.userWay isEqualToString:@"WS"]) { //WS用户
        sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSugarFightWSVC class]) bundle:nil];
        
    }else{ //非WS用户
        sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHSugarFightNotWSVC class]) bundle:nil];
    }
    YHViewController *vc = [sb instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

/**
 *  检查是否有远程通知,及是否有目标界面
 *
 *  @return 返回YES,表示有远程通知,有目标界面
 */
- (BOOL)checkRemoteNoteDestinVc{
    
    NSDictionary *dic = [GlobeSingle shareGlobeSingle].remoteNote;
    if (!dic) return NO; //值为空,表示没有远程通知
    //有值代表有远程通知
    YHPushModel *pushM = [YHPushModel mj_objectWithKeyValues:dic];
    
    if (pushM.PING) { //有ping字段表示跳转到commetsVc
        YHCommentsListVC *vc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHCommentsListVC class])];
        vc.pushM = pushM;
        vc.hideCmtField = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        
        //用过之后清空,程序运行期间保持为nil,用来判断用户点击通知时,程序是不是由死到生.
        [GlobeSingle shareGlobeSingle].remoteNote = nil;
        return YES;
    }
    return NO;
}

@end
