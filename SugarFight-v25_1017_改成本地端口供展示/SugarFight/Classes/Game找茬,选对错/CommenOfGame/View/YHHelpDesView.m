//
//  YHHelpDesView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHHelpDesView.h"
#import "YHPopView.h"
#import "YHHelpInfoResult.h"

@interface YHHelpDesView()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** 内容label*/
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** NSMutableParagraphStyle */
@property (nonatomic, strong) NSMutableParagraphStyle *style;
/** <#注释#> */
@property (nonatomic, weak) YHPopView *popView;
@end

//static YHPopView *popView_;

@implementation YHHelpDesView

- (YHPopView *)popView{
    if (!_popView) {
        YHPopView *popView = [YHPopView popView];
        _popView = popView;
        _popView.contentView = self;
    }
    return _popView;
}

- (NSMutableParagraphStyle *)style{
    if (!_style) {
        // paragraph style _style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy]; _style.alignment = NSTextAlignmentLeft; //对齐 _style.headIndent = 0.0f;//止尾缩进 _style.firstLineHeadIndent = 10.0f;//尾止缩进 _style.tailIndent]
        
        // paragraph style
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentLeft;  //对齐
        style.headIndent = 0.0f;//行首缩进
        //    style.firstLineHeadIndent = 20.0f;//首行缩进
        style.firstLineHeadIndent = self.contentLabel.font.pointSize * 2;
        style.tailIndent = 0.0f;//行尾缩进
        //    style.lineSpacing = 2.0f;//行间距
        self.style = style;
    }
    return _style;
}

- (void)awakeFromNib{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentLabel.font = YHFontYaHei(14);
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setup{
//    YHPopView *popView = [YHPopView popView];
//    popView_ = popView;
//    popView_.contentView = self;
    
    CGFloat x = 50;
    CGFloat w = YHScreenW - 2 * x;
    CGFloat h = YHScreenH * 0.5;
    CGFloat y = (YHScreenH - h) * 0.5;
    self.frame = CGRectMake(x, y, w, h);
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.contentLabel.text attributes:@{NSParagraphStyleAttributeName : self.style}];
    self.contentLabel.attributedText = attrText;
}

#pragma mark ------------------------------------------
#pragma mark external method
+ (YHHelpDesView *)helpDesView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setHelpInfoResult:(YHHelpInfoResult *)helpInfoResult{
    _helpInfoResult = helpInfoResult;
    NSMutableString *msg = [NSMutableString string];
    for (YHHelpInfoMsgModel *helpMsg in helpInfoResult.helpMsgs) {
        [msg appendString:[NSString stringWithFormat:@"%@:\n", helpMsg.title]];
        [msg appendString:[NSString stringWithFormat:@"%@\n\n", helpMsg.content]];
    }
    
    self.contentLabel.text = msg;
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)cfmAction:(id)sender {
//    popView_.hidePoint = self.hidePoint;
    [self.popView dismiss];
}

- (void)show{
    [self.popView show];
}

- (void)dismiss{
    [self.popView dismiss];
}

@end
