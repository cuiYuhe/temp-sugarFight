//
//  YHCommentTextField.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommentTextField.h"

NSInteger const YHTextMaxLength = 70;

@implementation YHCommentTextField


- (void)setup{
    [super setup];
    self.tintColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    
    self.targetOffsetView = self.superview;
    self.marginToKeyboard = 0.0f;
    
    [self addTarget:self action:@selector(commentEditing:) forControlEvents:UIControlEventEditingChanged];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}


- (void)commentEditing:(UITextField *)field{
    
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)view;
//            btn.backgroundColor = [UIColor whiteColor];
//            [btn setImage:[UIImage imageNamed:@"top_box_zan_left"] forState:UIControlStateNormal];
//        }
//    }
    
    if (field.text.length > YHTextMaxLength) {
        [MBProgressHUD showError:@"评论最多不能超过70字"];
        [field deleteBackward];
    }
}

@end
