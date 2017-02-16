//
//  YHGameVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/18.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
#import <SDWebImageDownloaderOperation.h>
#import "YHPopAllScreenImageView.h"
#import "YHAccusationBtn.h"
#import "YHHelpButton.h"
#import "YHHelpInfoParam.h"
#import "YHCommentsListVC.h"
#import "YHCommentsListParam.h"
#import "YHImageBrowser.h"
#import "YHPopView.h"

@interface YHGameVc : YHViewController
/** 用来取消下载图片的操作 */
@property (nonatomic, strong) NSMutableArray<id <SDWebImageOperation>> *imageOperations;
/** images字典,缓存使用: stringUrl : image */
@property (nonatomic, strong) NSMutableDictionary *imagesDic;



///判断剩余赞的按钮是否隐藏.因为'剩余赞的按钮'在sb中,所以需要传入.
- (void)isHideLeftZanBtn:(UIButton *)leftZanBtn;

/**
 *  根据url数据,设置imageView数组的图片
 *
 *  @param imageViews 需要设置图片的imageViews数组
 *  @param stringUrls 图片的url数组
 *  @param completed  完成回调
 *  @param failed     失败回调
 */
- (void)setImagesWithImageViews:(NSArray *)imageViews stringUrls:(NSArray *)stringUrls completed:(void(^)())completed failed:(void(^)(NSError *error))failed;
@end
