//
//  YHTitlesResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHTitleSingleModel.h"

@interface YHTitlesResult : YHBaseModel

/**
 "status": 1,
 "msg": "标题信息列表请求成功",
 "titleMsgs": [

 */

/** 标题数组  */
@property (nonatomic, strong) NSArray<YHTitleSingleModel *> *titleMsgs;


/**
 *  设置titleImageView的标题图片
 *
 *  @param titleType 标题类别,枚举
 *  @param imageView 要设置图片的标题imageView
 */
- (void)setTitleImageWithTitleType:(YHTitleType)titleType titleImageView:(UIImageView *)imageView;

@end
