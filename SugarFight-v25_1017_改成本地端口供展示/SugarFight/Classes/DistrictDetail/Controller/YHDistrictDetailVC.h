//
//  YHDistrictDetailVC.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/13.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHHeadDistrictMsgModel.h"
#import "YHDistrictDetailParam.h"

@interface YHDistrictDetailVC : UIViewController
/** title image name */
@property (nonatomic, copy) NSString *titleOfTop;
/** YHDistrictDetailParam */
@property (nonatomic, strong) YHDistrictDetailParam *paramOfDistrictDetail;
@end
