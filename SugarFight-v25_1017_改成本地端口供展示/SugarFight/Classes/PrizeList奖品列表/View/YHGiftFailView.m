//
//  YHGiftFailView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGiftFailView.h"

@implementation YHGiftFailView


- (IBAction)onceMoreAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(giftFailViewDidClickOnceMore:)]){
        [self.delegate giftFailViewDidClickOnceMore:self];
    }
}

@end
