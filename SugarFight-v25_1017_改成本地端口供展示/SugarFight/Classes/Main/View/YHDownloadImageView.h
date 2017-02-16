//
//  YHDownloadImageView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDownloadImageView : UIImageView
/** 下载图片时的下载进度 */
@property (nonatomic, assign) CGFloat progress;
/** 是否隐藏progressView */
@property (nonatomic, assign, getter=isHiddenProgressView) BOOL hiddenProgressView;


- (void)setup;

- (void)yh_setImageWithUrl:(NSString *)stringUrl completed:(void(^)(UIImage *image, NSError *error))completed;

- (void)stopDownLoadImage;
@end
