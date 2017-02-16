//
//  YHIndentLabel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHIndentLabel.h"

static CGFloat const YHLabelIndent = 5.0f;

@interface YHIndentLabel()
/** NSMutableParagraphStyle */
@property (nonatomic, strong) NSMutableParagraphStyle *style;
@end

@implementation YHIndentLabel

- (NSMutableParagraphStyle *)style{
    if (!_style) {
        self.style = [[NSMutableParagraphStyle alloc] init];
        self.style.headIndent = YHLabelIndent;
        self.style.firstLineHeadIndent = YHLabelIndent;
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

- (void)setup{
    
}

- (void)setText:(NSString *)text
{
    self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName : self.style}];
}

@end
