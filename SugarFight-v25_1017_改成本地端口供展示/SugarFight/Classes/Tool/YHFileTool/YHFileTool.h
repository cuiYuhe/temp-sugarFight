//
//  YHFileTool.h
//  testForAfn
//
//  Created by Cui yuhe on 16/3/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

@interface YHFileTool : NSObject

SingleH(YHFileTool)

///文件是否存在
+ (BOOL)fileIsExistInCache: (NSString *)filename;

///文件名的cache路径
+ (NSString *)getCacheFilePath: (NSString *)filename;

///文件名的Document路径
+ (NSString *)getDocumentFilePath: (NSString *)filename;

/**
 *  删除path路径的文件
 *
 *  @param Path 文件路径(文件或文件夹)
 */
+ (void)removeFilesAtPath:(NSString *)Path;



/**
 *  保存模型数据到NSDocumentDirectory
 *
 *  @param model    模型
 *  @param fileName 保存的文件名称
 */
+ (void)saveModel:(id)model fileName:(NSString *)fileName;

/**
 *  从NSDocumentDirectory中获取模型
 *
 *  @param model    模型
 *  @param fileName 保存的文件名称
 */
+ (instancetype)readModelWithFileName:(NSString *)fileName;

@end
