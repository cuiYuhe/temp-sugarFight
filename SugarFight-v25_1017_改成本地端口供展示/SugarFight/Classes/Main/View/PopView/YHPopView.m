//
//  YHPopView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopView.h"

@interface YHPopView()
/** UIWindow */
@property (nonatomic, strong) UIWindow *window;
@end


@implementation YHPopView
- (UIWindow *)window{
    if (!_window) {
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor clearColor];
    }
    return _window;
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

- (void)setup{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapGes];
    
    if (!self.superview) {
        [self.window addSubview:self];
        self.frame = self.window.bounds;
    }
    
}

#pragma mark ------------------------------------------
#pragma mark internal method
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    CGRect rectOfContentViewF = [self.contentView.superview convertRect:self.contentView.frame toView:window_];
//    if (CGRectContainsPoint(rectOfContentViewF, point)) {
//        return nil;
//    }
//    return self;
//}

#pragma mark ------------------------------------------
#pragma mark external method
+ (YHPopView *)popView{
    YHPopView *popView = [[self alloc] init];
    
    [popView addSubview:popView.contentView];
    //设置center,如果从xib中创建,直接居中显示.这个尺寸设置可被覆盖.
    popView.contentView.center = popView.center;
    return popView;
}

- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
    [self addSubview:self.contentView];
    contentView.center = self.center;
}

- (void)show{
    self.alpha = 1;
    self.window.hidden = NO;
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        _window.hidden = YES;
        _window = nil;
    }];
}


#pragma mark ------------------------------------------
#pragma mark gestureRecognizer
- (void)tap:(UITapGestureRecognizer *)tapGes{
    
    if (self.isClickNoResponse) {
        return;
    }
    CGRect rectOfContentViewF = [self.contentView.superview convertRect:self.contentView.frame toView:self.window];
    //如果点落在contentView上面,则什么都不做.由contentView 来处理
    CGPoint point = [tapGes locationInView:self];
    if (CGRectContainsPoint(rectOfContentViewF, point)) return;
    
    [self dismiss];
}

@end
