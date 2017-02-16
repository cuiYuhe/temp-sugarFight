//
//  YHReportToolDelegate.h
//  举报按钮
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//
//单抽出来一个delegate,是为了统一处理举报信息

#import <Foundation/Foundation.h>
#import "YHAccuationParam.h"

@interface YHAccusationToolDelegateObj : NSObject

/** 举报时的参数 */
@property (nonatomic, strong) YHAccuationParam *paramOfAccusation;

/**
 *  ///弹出警告vc,必须在控制器的didAppear中调用,因为需要弹出alertVc
 *
 *  @param vc 弹出alertVc的vc
 */
- (void)accuseWithVc:(UIViewController *)vc;
@end
