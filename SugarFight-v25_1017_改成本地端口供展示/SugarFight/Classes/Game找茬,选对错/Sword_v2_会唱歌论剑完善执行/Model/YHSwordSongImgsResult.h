//
//  YHSwordSongImgsResult.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseModel.h"
#import "YHSwordSongImgSubModel.h"

@interface YHSwordSongImgsResult : YHBaseModel

/** imgs 数组 */
@property (nonatomic, strong) YHSwordSongImgSubModel *imgs;
@end
