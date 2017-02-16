//
//  YHProgressView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <DALabeledCircularProgressView.h>

/**
 *  将框架中的init方法注释了,因为发现不调用initWithFrame方法了,
 1.框架中在initWithFrame方法中添加的progressLabel,
 2.自己重写initWithFrame做一些初始化设置
 - (id)init
 {
     return [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
 }
 */
@interface YHLabeledCircularProgressView : DALabeledCircularProgressView

@end
