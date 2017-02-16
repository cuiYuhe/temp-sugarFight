//
//  YHFileTool.m
//  testForAfn
//
//  Created by Cui yuhe on 16/3/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHFileTool.h"
/** file manager */
static NSFileManager *_manager;

@implementation YHFileTool
SingleM(YHFileTool)

+ (NSFileManager *)manager{
    if (!_manager) {
        _manager = [NSFileManager defaultManager];
    }
    return _manager;
}
#pragma mark ------------------------------------------
#pragma mark external methods
+ (BOOL)fileIsExistInCache: (NSString *)filename{
    
    NSString *filePath = [self getCacheFilePath:filename];
    return [[self manager] fileExistsAtPath:filePath];
}

+ (NSString *)getCacheFilePath: (NSString *)filename{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:filename];
}

+ (NSString *)getDocumentFilePath: (NSString *)filename{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:filename];
}

+ (void)removeFilesAtPath:(NSString *)Path{
    
    //判断文件是否存在,是否是路径
    BOOL isDirectory;
    BOOL isExit = [[self manager] fileExistsAtPath:Path isDirectory:&isDirectory];
    
    //如果不存在,抛出异常
    if (!isExit){
        return;
    }
    //如果不是文件夹,直接删除
    if (!isDirectory) {
        [[self manager] removeItemAtPath:Path error:nil];
        
    }else{
        NSArray *subPaths = [[self manager] subpathsAtPath:Path];
        for (NSString *subPath in subPaths) {
            
            NSString *filePath = [Path stringByAppendingPathComponent:subPath];
            [[self manager] removeItemAtPath:filePath error:nil];
        }
    }
}

///保存模型数据到document
+ (void)saveModel:(id)model fileName:(NSString *)fileName{
    
    //如fileName为'model', 保存文件名称为'model.data'
    NSString *filePath = [self getDocumentFilePath:[NSString stringWithFormat:@"%@.data", fileName]];
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}

///从NSDocumentDirectory中获取模型
+ (instancetype)readModelWithFileName:(NSString *)fileName{
    //如fileName为'model', 保存文件名称为'model.data'
    NSString *filePath = [self getDocumentFilePath:[NSString stringWithFormat:@"%@.data", fileName]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


@end
