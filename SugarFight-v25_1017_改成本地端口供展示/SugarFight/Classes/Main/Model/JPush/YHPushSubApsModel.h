//
//  YHPushSubApsModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/1.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPushSubApsModel : NSObject



/** alert:你上传的图片被参赛嘉宾评论了，快去看看吧, */
@property (nonatomic, copy) NSString *alert;
/** badge:26, */
@property (nonatomic, strong) NSNumber *badge;

/** sound: */
@property (nonatomic, copy) NSString *sound;


@end
