//
//  YHLoginField.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/19.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHLoginField.h"

@implementation YHLoginField

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
    UIView *leftV = [[UIView alloc] init];
    leftV.frame = CGRectMake(0, 0, 8, 0);
    self.leftView = leftV;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.tintColor = [UIColor whiteColor];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

//重写方法
- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)view;
        [btn setImage:[UIImage imageNamed:@"clear_white"] forState:UIControlStateNormal];
    }
}


@end
