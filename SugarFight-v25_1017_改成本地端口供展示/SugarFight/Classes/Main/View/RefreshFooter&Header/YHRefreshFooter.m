//
//  YHRefreshFooter.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHRefreshFooter.h"

@implementation YHRefreshFooter

- (void)prepare{
    [super prepare];
    self.automaticallyHidden = YES;
    [self setTitle:@"正在以箭速加载中.." forState:MJRefreshStateRefreshing];
}

@end
