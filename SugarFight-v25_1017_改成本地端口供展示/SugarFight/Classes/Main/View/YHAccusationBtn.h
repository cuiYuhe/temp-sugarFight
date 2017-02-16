//
//  YHAccusationBtn.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHAccusationToolDelegateObj.h"

@interface YHAccusationBtn : UIButton

/** 举报tool的代理 */
@property (nonatomic, strong) YHAccusationToolDelegateObj *accusDelegate;

@end
