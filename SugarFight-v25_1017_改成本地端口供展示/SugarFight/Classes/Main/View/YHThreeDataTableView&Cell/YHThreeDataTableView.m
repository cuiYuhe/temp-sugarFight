//
//  YHThreeDataTableView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHThreeDataTableView.h"


@implementation YHThreeDataTableView

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
//    [self registerNib:[UINib nibWithNibName:NSStringFromClass([YHThreeDataCell class]) bundle:nil] forCellReuseIdentifier:[YHThreeDataCell identifier]];
//    [self registerClass:[YHThreeDataCell class] forCellReuseIdentifier:[YHThreeDataCell identifier]];
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}


@end
