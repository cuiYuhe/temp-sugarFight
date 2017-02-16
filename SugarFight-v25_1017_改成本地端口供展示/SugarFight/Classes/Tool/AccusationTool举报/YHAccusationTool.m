//
//  YHAccusationTool.m
//  举报按钮
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAccusationTool.h"

@interface YHAccusationTool()

/** 举报alertVc */
@property (nonatomic, strong) UIAlertController *alertVc;
/** 举报alertVc的OK按钮 */
@property (nonatomic, weak) UIAlertAction *okAction;
/** 弹出alertVc的vc */
@property (nonatomic, weak) UIViewController *vcOfPresenting;

@end

@implementation YHAccusationTool
SingleM(AccusationTool)

- (UIAlertController *)alertVc{
    if (!_alertVc) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"举报原因" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        self.alertVc = alertVc;
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *actionSex = [UIAlertAction actionWithTitle:self.accusationCauses[YHAccusationTypeSex] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            __strong __typeof(self) strongSelf = weakSelf;
            YHLog(@"%@--", strongSelf.accusationCauses[YHAccusationTypeSex]);
            
            if ([strongSelf.delegate respondsToSelector:@selector(accusationToolActionDidClick:accusationType:)]) {
                [strongSelf.delegate accusationToolActionDidClick:strongSelf accusationType:YHAccusationTypeSex];
            }
        }];
        
        UIAlertAction *actionAd = [UIAlertAction actionWithTitle:self.accusationCauses[YHAccusationTypeAd] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            __strong __typeof(self) strongSelf = weakSelf;
            YHLog(@"%@--", self.accusationCauses[YHAccusationTypeAd]);
            
            if ([strongSelf.delegate respondsToSelector:@selector(accusationToolActionDidClick:accusationType:)]) {
                [strongSelf.delegate accusationToolActionDidClick:strongSelf accusationType:YHAccusationTypeAd];
            }
        }];
        
        UIAlertAction *actionCheat = [UIAlertAction actionWithTitle:self.accusationCauses[YHAccusationTypeCheat] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            __strong __typeof(self) strongSelf = weakSelf;
            YHLog(@"%@--", self.accusationCauses[YHAccusationTypeCheat]);
            
            if ([strongSelf.delegate respondsToSelector:@selector(accusationToolActionDidClick:accusationType:)]) {
                [strongSelf.delegate accusationToolActionDidClick:strongSelf accusationType:YHAccusationTypeCheat];
            }
        }];
        
        UIAlertAction *actionOther = [UIAlertAction actionWithTitle:self.accusationCauses[YHAccusationTypeOther] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            __strong __typeof(self) strongSelf = weakSelf;
            YHLog(@"%@--", strongSelf.accusationCauses[YHAccusationTypeOther]);
            [strongSelf otherCause];
        }];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
        
        [alertVc addAction:actionSex];
        [alertVc addAction:actionAd];
        [alertVc addAction:actionCheat];
        [alertVc addAction:actionOther];
        [alertVc addAction:actionCancel];
    }
    return _alertVc;
}

- (NSArray *)accusationCauses{
    if (!_accusationCauses) {
        self.accusationCauses = @[@"色情", @"广告", @"诈骗", @"其它"];
    }
    return _accusationCauses;
}

#pragma mark ------------------------------------------
#pragma mark external method
///弹出警告vc
- (void)accuseWithVc:(UIViewController *)vc{
    [vc presentViewController:self.alertVc animated:YES completion:nil];
    self.vcOfPresenting = vc;
}

#pragma mark ------------------------------------------
#pragma mark internal method
///'其它'举报的事件
- (void)otherCause{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"其它原因" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    //添加cancel,ok.以及txtFld以输入原因
    __weak typeof(self) weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([weakSelf.delegate respondsToSelector:@selector(accusationToolActionDidFinishAccusationOtherText:accusationCause:)]) {
            [weakSelf.delegate accusationToolActionDidFinishAccusationOtherText:self accusationCause:alertVc.textFields.firstObject.text];
        }
    }];
    okAction.enabled = NO;
    self.okAction = okAction;
    
    [alertVc addAction:cancelAction];
    [alertVc addAction:okAction];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    }];
    [self.vcOfPresenting presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark ------------------------------------------
#pragma mark observe method
- (void)editingChanged:(UITextField *)textField{
    self.okAction.enabled = textField.text.length > 0;
}

@end
