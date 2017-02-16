//
//  YHHttpTool.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/26.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHMd5CheckParam;

NS_ASSUME_NONNULL_BEGIN

@interface YHHttpTool : NSObject
SingleH(HttpTool)

/** test */
@property (nonatomic, copy) NSString *testBaseUrl;

/**
 *  POST请求,需要将参数序列化成data
 *
 *  @param url     网址
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)postByJSONDataWithUrl:(NSString *)url
                       params:(NSDictionary *_Nullable)params
                      success:(void(^)(id responseObj))success
                      failure:(void(^)(NSError * _Nonnull error))failure;

/**
 *  POST请求,不用序列化成data
 *
 *  @param url     网址
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)postNotByJSONDataWithUrl:(NSString *)url
                       params:(NSDictionary *_Nullable)params
                      success:(void(^)(id responseObj))success
                      failure:(void(^)(NSError * _Nonnull error))failure;


//+ (void)checkMd5IsExist:(NSString *)md5
//                success:(void(^)(id responseObj))success
//                failure:(void(^)(NSError * _Nonnull error))failure;

///检查图片的md5是否重复
+ (void)checkMd5IsExist:(YHMd5CheckParam *)md5Param
                success:(void(^)(id responseObj))success
                failure:(void(^)(NSError * _Nonnull error))failure;





///同步请求,成功
+ (void)checkSyncMd5IsExist:(NSString *)md5;
///检验md5是否存在
+ (void)checkMd5IsExistTestSync:(NSString *)md5;

+(NSDictionary*)PostRequestSyncWithUrlString:(NSString*)urlString parameters:(NSDictionary*)dic;

///同步请求,成功
+(void)sendRequestSyncWithUrlString:(NSString*)urlString parameters:(NSDictionary*)dic Success: (void(^)( NSDictionary* _Nullable returnDic))success Failure:(void (^)(NSError * _Nullable error))failure;

///同步请求,成功,无回调
+(NSDictionary*)sendRequestSyncWithUrlString:(NSString*)urlString parameters:(NSDictionary*)dic;

///通知server获得图片成功
+ (void)informServerDownloadImgSuccess;

///取消所有请求,如果当前有需要存在的请求,如下载上传等,则不能取消
+ (void)cancelAllTasks;

@end


NS_ASSUME_NONNULL_END