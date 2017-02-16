//
//  YHStudyListCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHCourseModel;

@interface YHStudyListCell : UITableViewCell

/** YHCourseModel */
@property (nonatomic, strong) YHCourseModel *course;

+ (NSString *)identifier;
@end
