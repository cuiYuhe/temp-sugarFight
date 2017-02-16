//
//  YHPrizeOwnerInfoVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPrizeOwnerInfoVc.h"
#import "YHLoginField.h"
#import "YHSubmitOwnerInfoParam.h" //提交地址信息等参数
#import "YHSubmitOwnerInfoResult.h"//提交地址信息等请求结果
#import "YHLoginModel.h"
#import "YHPrizeSubReceiverModel.h"
#import "NSString+Extension.h"
#import "YHPopAlertView.h"

///记录领奖收货信息
static NSString *const YHStrUrlSubmitOwnerInfo = @"jianpai/lottery/recordReceiverMsg";

@interface YHPrizeOwnerInfoVc ()<UITextFieldDelegate>
/** 收件人 */
@property (weak, nonatomic) IBOutlet YHLoginField *receiverField;
/** 联系电话 */
@property (weak, nonatomic) IBOutlet YHLoginField *telField;
/** 地址 */
@property (weak, nonatomic) IBOutlet YHLoginField *addressField;

@end

@implementation YHPrizeOwnerInfoVc

- (YHPrizeSubReceiverModel *)receiverM{
    if (!_receiverM) {
        self.receiverM = [[YHPrizeSubReceiverModel alloc] init];
    }
    return _receiverM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.receiverField becomeFirstResponder];
    
    if (self.receiverM) {
        self.receiverField.text = self.receiverM.name;
        self.telField.text = self.receiverM.tel;
        self.addressField.text = self.receiverM.address;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark ------------------------------------------
#pragma mark initialize
- (void)setup{
    self.receiverField.delegate = self;
    self.telField.delegate = self;
    self.addressField.delegate = self;
    
    //view添加tap事件
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tapGes];
}

#pragma mark ------------------------------------------
#pragma mark private method
///成功提交信息后的操作
- (void)setupAfterSubmitInfo{
    
    //更新receiverM
    self.receiverM.name = self.receiverField.text;
    self.receiverM.tel = self.telField.text;
    self.receiverM.address = self.addressField.text;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(prizeOwnerInfoVcDidSubmitPrizeInfo:prizeOwnerInfoM:)]) {
        [self.delegate prizeOwnerInfoVcDidSubmitPrizeInfo:self prizeOwnerInfoM:self.receiverM];
    }
}

///field是否含有表情
- (BOOL)checkIfThereIsEmojiInField{
    BOOL isHave = NO;
    NSString *texts = [NSString stringWithFormat:@"%@%@%@", self.receiverField.text, self.telField.text, self.addressField.text];
    if (texts.length > 0) {
        if ([texts yh_containsEmoji]) {
            isHave = YES;
            YHPopAlertView *pav = [YHPopAlertView popAlertViewSingleBtnWithContent:@"输入内容,不能含有表情." cfm:nil];
            [pav show];
        }
    }
    
    return isHave;
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    
    if (self.receiverField.text.length == 0 ||
        self.telField.text.length == 0 ||
        self.addressField.text.length == 0) { //用户没有提交个人信息
        
        if ([self.delegate respondsToSelector:@selector(prizeOwnerInfoVcWillDismissWhileNoSubmitInfo:)]) {
            [self.delegate prizeOwnerInfoVcWillDismissWhileNoSubmitInfo:self];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cfmAction:(UIButton *)sender {
    
    if (self.receiverField.text.length == 0 ||
        self.telField.text.length == 0 ||
        self.addressField.text.length == 0) {
        [MBProgressHUD showError:@"收件人,电话或地址不能为空!"];
        return;
    }
    
    if ([self checkIfThereIsEmojiInField]) {//有表情
        return;
    }

    [SVProgressHUD showWithStatus:nil];
    //提交信息
    YHSubmitOwnerInfoParam *param = [[YHSubmitOwnerInfoParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.name = self.receiverField.text;
    param.tel = self.telField.text;
    param.address = self.addressField.text;
    
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlSubmitOwnerInfo params:[param mj_keyValues] success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"信息提交成功."];
        YHSubmitOwnerInfoResult *result = [YHSubmitOwnerInfoResult mj_objectWithKeyValues:responseObj];
        if (result.status.integerValue == 1) {
            [self setupAfterSubmitInfo];
        }else{
            [MBProgressHUD showError:result.msg];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
    
}

#pragma mark ------------------------------------------
#pragma mark 手势
- (void)tapView:(UITapGestureRecognizer *)tapGes{
    [self.view endEditing:YES];
}


#pragma mark ------------------------------------------
#pragma mark UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    YHFunc
    if (textField == self.receiverField) {
        [self.telField becomeFirstResponder];
        
    }else if (textField == self.telField){
        [self.addressField becomeFirstResponder];
        
    }else if (textField == self.addressField){
        [self.view endEditing:YES];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self checkIfThereIsEmojiInField];
}


@end
