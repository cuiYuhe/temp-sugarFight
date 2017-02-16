//
//  CATFileCachesManager.h
//  101-BaiSi
//
//  Created by Cui yuhe on 16/1/11.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CATFileCachesManager : NSObject

/**
 *  获取文件夹尺寸大小
 *
 *  @param directoryPath 欲计算大小的文件夹路径
 *  @param completion    异步线程,计算完成回调block,以对主线程刷新
 */
+ (void)getDirectoryCacheSize:(NSString *)directoryPath completionBlock:(void(^)(CGFloat totalSize))completion;

/**
 *  移除文件(不需要异步,经验证15GB移除只要一瞬间)
 *
 *  @param Path 文件路径
 */
+ (void)removeFilesAtPath:(NSString *)Path;

/**
 *  将一个CGFloat的大小转化成相应的MB,KB或B
 *
 *  @param totalSize 一个值表示文件尺寸大小
 *
 *  @return 相应的MB,KB或B
 */
+ (NSString *)convertFileSizeToBytes:(CGFloat)totalSize;
@end
