//
//  YHRefreshHeader.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHRefreshHeader.h"

@interface YHRefreshHeader()

@end

@implementation YHRefreshHeader

- (void)prepare{
    [super prepare];
    // 添加label
//    self.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
//    self.arrowView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = YHGrayColorWithAlpha(255, 0.8);
}

@end
