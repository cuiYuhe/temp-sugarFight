//
//  YHPopAlertView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopAlertView.h"
#import "YHPopView.h"

static CGFloat const YHTitleFont = 18.0f;
static CGFloat const YHContentFont = 15.0f;
static CGFloat const YHContentToButtonMargin = 40.0f;
static CGFloat const YHBtnViewHeight = 30.0f;

@interface YHPopAlertView()
/** title标题label */
@property (nonatomic, weak) UILabel *titleLabel;
/** content label,内容label */
@property (nonatomic, weak) UILabel *contentLabel;
/** 包装'取消'与'确定'的view */
@property (nonatomic, assign) UIView *btnView;
/** cfm btn 确定按钮 */
@property (nonatomic, weak) UIButton *cfmBtn;
/** cancel btn 取消按钮 */
@property (nonatomic, weak) UIButton *cancelBtn;
/** YHPopview,自己的superView */
@property (nonatomic, weak) YHPopView *parentPopView;

/** 确定之后的操作 */
@property (nonatomic, copy) void(^cfmBlock)();
/** 取消之后的操作 */
@property (nonatomic, copy) void(^cancelBlock)();
@end

@implementation YHPopAlertView

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
    YHPopView *pv = [YHPopView popView];
    pv.clickNoResponse = YES;
    self.parentPopView = pv;
    pv.contentView = self;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:YHTitleFont];
    self.titleLabel = titleLabel;
    titleLabel.text = @"提示";
    [self addSubview:titleLabel];
    
    //content
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:YHContentFont];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
    
    //btnView
    UIView *btnView = [[UIView alloc] init];
    self.btnView = btnView;
    [self addSubview:btnView];
    
    //cancel btn
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn = cancelBtn;
    [self.btnView addSubview:cancelBtn];
    
    //cfm btn
    UIButton *cfmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cfmBtn addTarget:self action:@selector(cfmClick) forControlEvents:UIControlEventTouchUpInside];
    [cfmBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    self.cfmBtn = cfmBtn;
    [self.btnView addSubview:cfmBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat viewX = 30;
    CGFloat viewW = self.parentPopView.yh_width - 2 * viewX;
    CGFloat viewH = self.parentPopView.yh_height;
    CGFloat viewY = 0;
    self.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    //title
    CGFloat titleX = 0;
    CGFloat titleY = margin;
    CGFloat titleW = self.yh_width;
    CGFloat titleH = 20;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //content
    CGFloat contentX = margin;
    CGFloat contentY = CGRectGetMaxY(self.titleLabel.frame) + margin;
    CGFloat contentW = self.yh_width - 2 * margin;
    CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);
    NSDictionary *contentAttrs = @{NSFontAttributeName : self.contentLabel.font};
    CGFloat contentH = [self.contentLabel.text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttrs context:nil].size.height;
    self.contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    //btn
    //1.btn view
    CGFloat btnViewX = 0;
    CGFloat btnViewY = CGRectGetMaxY(self.contentLabel.frame) + YHContentToButtonMargin;
    CGFloat btnViewW = self.yh_width;
    CGFloat btnViewH = YHBtnViewHeight;
    self.btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
    
    if (self.btnView.subviews.count == 1) {//只有一个btn
        self.cfmBtn.frame = self.btnView.bounds;
    }else if (self.btnView.subviews.count == 2){
        
        //cancel btn
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = 0;
        CGFloat cancelBtnW = self.btnView.yh_width / 2;
        CGFloat cancelBtnH = self.btnView.yh_height;
        self.cancelBtn.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
        //cfm btn
        CGFloat cfmBtnX = CGRectGetMaxX(self.cancelBtn.frame);
        CGFloat cfmBtnY = 0;
        CGFloat cfmBtnW = self.btnView.yh_width / 2;
        CGFloat cfmBtnH = self.btnView.yh_height;
        self.cfmBtn.frame = CGRectMake(cfmBtnX, cfmBtnY, cfmBtnW, cfmBtnH);
    }
    
    //更改高度
    self.yh_height = CGRectGetMaxY(self.btnView.frame) + margin;
    self.yh_y = (self.parentPopView.yh_height - self.yh_height) / 2;
    
}

#pragma mark ------------------------------------------
#pragma mark 外部set方法
- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setContent:(NSString *)content{
    _content = [content copy];
    self.contentLabel.text = content;
    [self setNeedsLayout];
}

#pragma mark ------------------------------------------
#pragma mark event
- (void)cancelClick{
    
    [self.parentPopView dismiss];
    !self.cancelBlock ? : self.cancelBlock();
}

- (void)cfmClick{
    
    [self.parentPopView dismiss];
    !self.cfmBlock ? : self.cfmBlock();
}

#pragma mark ------------------------------------------
#pragma mark public method
- (void)show{
    [self.parentPopView show];
}

- (void)dismiss{
    [self.parentPopView dismiss];
}

//只设置提示内容
+ (YHPopAlertView *)popAlertViewSingleBtnWithContent:(NSString *)content cfm:(void (^)())cfmBlock{
    YHPopAlertView *pav = [[self alloc] init];
    [pav.cancelBtn removeFromSuperview];

    pav.content = content;
    pav.cfmBlock = cfmBlock;
    return pav;
}

//既设置提示内容,也设置标题
+ (YHPopAlertView *)popAlertViewSingleBtnWithTitle:(NSString *)title content:(NSString *)content cfm:(void (^)())cfmBlock{
    
    YHPopAlertView *pav = [self popAlertViewSingleBtnWithContent:content cfm:cfmBlock];
    pav.title = title;
    return pav;
}

+ (YHPopAlertView *)popAlertViewDoubleBtnWithContent:(NSString *)content cfm:(void (^)())cfmBlock cancel:(void (^)())cancelBlock{
    YHPopAlertView *pav = [[self alloc] init];
    pav.content = content;
    pav.cfmBlock = cfmBlock;
    pav.cancelBlock = cancelBlock;
    return pav;
}

/**
 *  创建接收到服务器通知时的alertView,两个btn标题为:'待会再看','去看看'
 */
+ (__kindof YHPopAlertView *)popAlertViewOfNotificationWithContent:(NSString *)content cfm:(void(^)())cfmBlock cancel:(void(^)())cancelBlock{
    YHPopAlertView *pav = [self popAlertViewDoubleBtnWithContent:content cfm:cfmBlock cancel:cancelBlock];
    [pav.cancelBtn setTitle:@"待会再看" forState:UIControlStateNormal];
    [pav.cfmBtn setNormalTitle:@"去看看"];
    return pav;
}

@end
