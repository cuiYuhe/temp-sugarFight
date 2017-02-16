//
//  YHSeeUploadGridImgCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/20.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGridImagesCell.h"


@interface YHSeeUploadGridImgCell : YHGridImagesCell
/** url */
@property (nonatomic, copy) NSString *imgUrl;
/** 是否停止下载图片 */
@property (nonatomic, assign, getter=isStopLoadImage) BOOL stopLoadImage;


@end
