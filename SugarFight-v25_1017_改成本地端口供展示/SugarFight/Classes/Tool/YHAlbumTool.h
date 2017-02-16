//
//  YHAlbumTool.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHAlbumTool;

@protocol YHAlbumToolDelegate <NSObject>

@optional

/** 返回用户从相册中选择的照片 */
- (void)albumToolDidSelectImage:(UIImage *)image albumTool:(YHAlbumTool *)albumTool;

@end

@interface YHAlbumTool : NSObject
SingleH(AlbumTool)

/** delegate */
@property (nonatomic, weak) id<YHAlbumToolDelegate> delegate;

/**
 *  打开相册
 *
 *  @param vc 弹出imagePickerController的控制器
 */
- (void)openAlbumWithVc:(UIViewController *)vc;
@end
