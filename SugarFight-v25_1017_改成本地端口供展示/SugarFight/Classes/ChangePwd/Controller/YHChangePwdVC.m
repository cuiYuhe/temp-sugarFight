//
//  YHChangePwdVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/20.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHChangePwdVC.h"
#import "YHLoginField.h"
#import "YHLoginOffVC.h"
#import "YHChangePwdParam.h"
#import "YHChangePwdModel.h"

static NSString *const YHStrUrl = @"jianpai/User/changePwd";
static NSString *const YHSouceParam = @"ios";

@interface YHChangePwdVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet YHLoginField *originalPwdField;
/** 不能以new开头,所以两个n */
@property (weak, nonatomic) IBOutlet YHLoginField *modifyPwdField;
@property (weak, nonatomic) IBOutlet YHLoginField *cfmPwdField;
/** 正在编辑的field */
@property (nonatomic, weak) YHLoginField *editingField;
/** change pwd model */
@property (nonatomic, strong) YHChangePwdModel *changePwdM;
/** 确认密码与新密码相同时的提醒 */
@property (weak, nonatomic) IBOutlet UIImageView *pwdNoticeImgView;

@end

@implementation YHChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup{
    self.modifyPwdField.delegate = self;
    self.cfmPwdField.delegate = self;
    self.originalPwdField.delegate = self;
    [self.cfmPwdField addTarget:self action:@selector(modifyPwdChanged:) forControlEvents:UIControlEventEditingChanged];
    
//    监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    //添加手势
    UITapGestureRecognizer *hidekeyboard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidekeyboard)];
    [self.view addGestureRecognizer:hidekeyboard];
    
}

#pragma mark ------------------------------------------
#pragma mark events
- (void)modifyPwdChanged:(UITextField *)field{
    if (field.text.length == 0) return; //field为空,不比较
    self.pwdNoticeImgView.hidden = ![field.text isEqualToString:self.modifyPwdField.text];
}

- (IBAction)cfmAction:(UIButton *)sender {
    YHFunc
    if (self.originalPwdField.text.length == 0 || self.modifyPwdField.text.length == 0 || self.cfmPwdField.text.length == 0) {//有一个输入框密码为空
        [MBProgressHUD showError:@"密码都不能为空"];
        return;
    }else if (![self.modifyPwdField.text isEqualToString:self.cfmPwdField.text]){
        [MBProgressHUD showError:@"两次输入密码不一致, 请重新输入"];
        return;
        
    }else if ([self.modifyPwdField.text isEqualToString: self.cfmPwdField.text]){ //比较旧密码是否正确
        
        NSString *oldPwd = [[NSUserDefaults standardUserDefaults] objectForKey: YHPwdKey];
        if (oldPwd && self.originalPwdField.text != oldPwd) {
            [MBProgressHUD showError:@"原密码错误"];
            return;
            
        }else {

            YHChangePwdParam *param = [[YHChangePwdParam alloc] init];
            param.uid = [GlobeSingle shareGlobeSingle].userID;
            param.source = YHSouceParam;
            param.oldPwd = self.originalPwdField.text;
            param.modifyPwd = self.modifyPwdField.text;
            param.cfmPwd = self.cfmPwdField.text;
            param.uuid = [GlobeSingle shareGlobeSingle].loginM.message;
            NSDictionary *dicParam = param.mj_keyValues;
            
            [YHHttpTool postByJSONDataWithUrl:YHStrUrl params:dicParam success:^(id  _Nonnull responseObj) {
                
                self.changePwdM = [YHChangePwdModel mj_objectWithKeyValues:responseObj];
               
                if (self.changePwdM.stuatus.integerValue == 3) { //没有错误,保存
                    [[NSUserDefaults standardUserDefaults] setObject:self.modifyPwdField.text forKey: YHPwdKey];
                    [MBProgressHUD showSuccess:@"修改密码成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self backAction:nil];
                    });
                    
                }else{
                    NSString *errorInfo = self.changePwdM.message;
                    [MBProgressHUD showError:errorInfo];
                }
                
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showError:@"请检查网络,稍后重试."];
                YHLog(@"error = %@", error);
            }];
        }
    }

}

- (IBAction)backAction:(id)sender {
    
    //判断自己是不是被将显示的vc,modal出来.
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YHLoginOffVC class]) bundle:nil];
    YHLoginOffVC *loginOffVc = [sb instantiateInitialViewController];
    
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:loginOffVc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
    
}

#pragma mark ------------------------------------------
#pragma mark 监听
-(void)keyboardWillShow:(NSNotification*)note
{
    CGRect keyboardF = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyH = keyboardF.size.height;
    
    //处于编辑状态的txtFld需要的移动量
    CGRect fieldF = [self.editingField.superview convertRect:self.editingField.frame toView:nil];
    CGFloat fieldMaxY = CGRectGetMaxY(fieldF);
    
    CGFloat margin = 100.0f;
    CGFloat offsetYNeed = fieldMaxY - (YHScreenH - keyH) + margin;

    YHLog(@"offsetYNeed = %f", offsetYNeed);
    //如果当前编辑的txtFld没有被键盘覆盖,则不需要偏移
    if (offsetYNeed < 0) {
        return;
    }
    
//    self.accountFldTopCons.constant -= offsetYNeed;
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -offsetYNeed);
    }completion:nil];
    
}

-(void)keyboardWillhide:(NSNotification*)note
{
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }completion:nil];
}

-(void)hidekeyboard{
    [self.view endEditing:YES];
}

#pragma mark ------------------------------------------
#pragma mark UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    YHFunc
    if (textField == self.originalPwdField) {
        [self.modifyPwdField becomeFirstResponder];
        
        
    }else if (textField == self.modifyPwdField){
        [self.cfmPwdField becomeFirstResponder];
        
    }else if (textField == self.cfmPwdField){
        [self.view endEditing:YES];
        [self cfmAction:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(YHLoginField *)textField{
    self.editingField = textField;
    
}

@end
