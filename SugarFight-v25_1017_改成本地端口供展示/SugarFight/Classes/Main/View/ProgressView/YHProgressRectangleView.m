//
//  YHProgressRectangleView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHProgressRectangleView.h"

@interface YHProgressRectangleView()

@end

@implementation YHProgressRectangleView
- (UIColor *)progressColor{
    if (!_progressColor) {
        if (!_progressColor) {
            _progressColor = YHrgbColor(51, 92, 86);;
        }
    }
    return _progressColor;
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
    //bg
    [super setup];
    self.backgroundColor = YHrgbColor(224, 44, 2);
    self.layer.cornerRadius = 3.0f;
    
}

- (void)setProgress:(CGFloat)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = NO;
        _progress = progress;
        [self setNeedsDisplay];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
//            self.hidden = progress == 1.0f;不使用此句!原因是影响设置hidden.
            if (progress == 1.0f) {
                self.hidden = YES;
            }
        });
    });
    
}


- (void)drawRect:(CGRect)rect{
    CGRect frame = CGRectMake(0, 0, self.progress * self.yh_width, self.yh_height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [self.progressColor set];
    [path fill];
}
@end
