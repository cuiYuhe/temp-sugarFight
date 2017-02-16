//
//  YHPopField.m
//  testPopFIeld
//
//  Created by Cui yuhe on 16/6/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopField.h"

static CGFloat YHMargin = 15.0f;

@interface YHPopField()
/** field在y方向上的偏移量 */
@property (nonatomic, assign) CGFloat offsetYNeed;
/** 偏移时,与键盘的间距.如果不设置,默认为15. */
@property (nonatomic, assign) CGFloat defautMarginToKeyboard;
@end

@implementation YHPopField

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
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    //1.监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    //2.textField与键盘的距离
    self.defautMarginToKeyboard = YHMargin;
    
}

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setMarginToKeyboard:(CGFloat)marginToKeyboard{
    self.defautMarginToKeyboard = marginToKeyboard;
}

#pragma mark ------------------------------------------
#pragma mark 监听
-(void)keyboardWillShow:(NSNotification*)note
{
    //0.因为一次键盘弹出会调用多次,系统的键盘调用了两次.
    self.targetOffsetView.transform = CGAffineTransformIdentity;
    //1.键盘高度
    CGRect keyboardF = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyH = keyboardF.size.height;
    //2.键盘弹出时间
    CGFloat animationTime = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //3.处于编辑状态的txtFld需要的移动量
    //3.1 先判断需要移动的控件是当前field,还是设置的targetOffsetView
    if (!self.targetOffsetView) {
        self.targetOffsetView = self;
    }
    CGRect fieldF = [self.targetOffsetView.superview convertRect:self.targetOffsetView.frame toView:nil];
    CGFloat fieldMaxY = CGRectGetMaxY(fieldF);
    //与底部的距离
    CGFloat marginToBottom = [UIScreen mainScreen].bounds.size.height - fieldMaxY;
    
    CGFloat offsetYNeed = 0.0f;
    if (keyH > marginToBottom) {
        offsetYNeed = keyH - marginToBottom + self.defautMarginToKeyboard;
    }
    
    self.offsetYNeed = offsetYNeed;
    //如果当前编辑的txtFld没有被键盘覆盖,则不需要偏移
    if (offsetYNeed <= 0) {
        return;
    }
    
    [UIView animateWithDuration:animationTime animations:^{
        self.targetOffsetView.transform = CGAffineTransformMakeTranslation(0, -offsetYNeed);
    }completion:nil];
    
}

-(void)keyboardWillhide:(NSNotification*)sender
{
    if (self.offsetYNeed < 0) {
        return;
    }
    self.targetOffsetView.transform = CGAffineTransformIdentity;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
