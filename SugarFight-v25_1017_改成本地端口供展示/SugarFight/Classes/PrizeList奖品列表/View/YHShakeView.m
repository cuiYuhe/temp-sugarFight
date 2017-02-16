//
//  YHShakeView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHShakeView.h"
#import <UIImage+GIF.h>

@interface YHShakeView()
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end

@implementation YHShakeView

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
    self.gifImageView.image = [UIImage sd_animatedGIFNamed:@"yaoyiyao"];
}
@end
