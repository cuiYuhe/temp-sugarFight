//
//  CATFileCachesManager.m
//  101-BaiSi
//
//  Created by Cui yuhe on 16/1/11.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "CATFileCachesManager.h"

@implementation CATFileCachesManager

#pragma mark ------------------------------------------
#pragma mark 计算缓存方法
+ (void)getDirectoryCacheSize:(NSString *)directoryPath completionBlock:(void(^)(CGFloat totalSize))completion{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    //判断文件是否存在,是否是路径
    BOOL isDirectory;
    BOOL isExit = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    //如果不存在,抛出异常
    if (!isExit || !isDirectory){
        NSException *exception = [NSException exceptionWithName:@"error" reason:[NSString stringWithFormat:@"传入的路径:%@ 不存在或者不是文件夹", directoryPath] userInfo:nil];
        [exception raise];
        return;
    }
    
    //路径下的全部子文件:包括所有的文件夹路径和文件路径
    NSArray *subPaths = [manager subpathsAtPath:directoryPath];
    
    //如果文件太大, 计算文件大小需要异步执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //记录传入路径的文件总大小
        CGFloat totalSize = 0.0f;
        for (NSString *subPath in subPaths) {
            
            //判断文件是否存在,是否是路径
            BOOL isDirectory;
            BOOL isExit = [manager fileExistsAtPath:subPath isDirectory:&isDirectory];
            
            //路径存在,且是不是文件夹,且不是隐藏文件.
            if (!isExit || !isDirectory || [subPath containsString:@".DS"]) {
                
                NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
                //路径下文件的信息
                NSDictionary *attr = [manager attributesOfItemAtPath:filePath error:nil];
                totalSize += [attr[NSFileSize] integerValue];
            }
        }
        
        //回到主线程,调用block,供调用者刷新UI或其它操作
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            completion(totalSize);
        });
    });
    
}


+ (void)removeFilesAtPath:(NSString *)Path{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断文件是否存在,是否是路径
    BOOL isDirectory;
    BOOL isExit = [manager fileExistsAtPath:Path isDirectory:&isDirectory];
    
    //如果不存在,抛出异常
    if (!isExit){
        NSException *exception = [NSException exceptionWithName:@"error" reason:[NSString stringWithFormat:@"传入的路径:%@ 不存在", Path] userInfo:nil];
        [exception raise];
        return;
    }
    
    //如果不是文件夹,直接删除
    if (!isDirectory) {
        [manager removeItemAtPath:Path error:nil];
        
    }else{
        NSArray *subPaths = [manager subpathsAtPath:Path];
        for (NSString *subPath in subPaths) {
            
            NSString *filePath = [Path stringByAppendingPathComponent:subPath];
            [manager removeItemAtPath:filePath error:nil];
        }
    }
}


+ (NSString *)convertFileSizeToBytes:(CGFloat)totalSize{
    //转化成B
    NSString *cachesStr = @"B";
    
    if (totalSize > 1000 * 1000 * 1000) {
        totalSize /= (1000 * 1000 * 1000);
        cachesStr = @"GB";
    }else if (totalSize > 1000 * 1000) {
        totalSize /= (1000 * 1000);
        cachesStr = @"MB";
    }else if (totalSize > 1000){
        totalSize /= 1000;
        cachesStr = @"KB";
    }else if (totalSize > 0){
        cachesStr = @"B";
    }
    cachesStr = [NSString stringWithFormat:@"%.1f %@", totalSize, cachesStr];
    return cachesStr;
    
}

@end
