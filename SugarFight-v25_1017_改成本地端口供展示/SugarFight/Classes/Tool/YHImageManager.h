//
//  YHImageManager.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHImageManager : NSObject
SingleH(ImageManager)


/**
 *  上传图片到OSS
 *
 *  @param images      待上传的 images 图片数组
 *  @param imageNames  子路径
 *  @param uploadError 上传结束后的错误回调,如果有错误,则上传失败
 */
- (void)uploadToOSS:(NSArray<UIImage *> *)images imageNames:(NSArray *)imageNames uploadError:(void(^)(NSError * error))uploadError;

@end
