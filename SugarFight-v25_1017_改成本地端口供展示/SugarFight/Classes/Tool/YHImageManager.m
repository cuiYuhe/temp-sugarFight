//
//  YHImageManager.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHImageManager.h"
#import "OSSService.h"
#import "OSSCompat.h"
#import "UIImage+Extension.h"

static NSString * const AccessKey = @"ltZQNlcNVTzzAFCK";
static NSString * const SecretKey = @"8VEXnbAfKjRSzaXwT4dQiCPUC1ruqh";

@interface YHImageManager()

/** ossclient */
@property (nonatomic, strong) OSSClient *client;
@end

@implementation YHImageManager
SingleM(ImageManager)

//OSS 上传
- (void)uploadToOSS:(NSArray<UIImage *> *)images imageNames:(NSArray *)imageNames uploadError:(void(^)(NSError * error))uploadError{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger count = images.count;
        NSError *uploadErr = nil;
        for (NSInteger i = 0; i < count; i++) {
//            NSData *imageData2 = UIImageJPEGRepresentation(images[i], 1.0);
            UIImage *originalImage = images[i];
            //压缩图片
            NSData *imageData = [originalImage yh_compressImageReturnData];
            YHLog(@"imageData.length = %zd", [imageData length]);

            //上传是否不成功
            uploadErr = [self uploadObjectSync:imageData imageName:imageNames[i]];
            if (uploadErr) break; //如果错误,停止,返回错误
            
            //上传成功一张图片,发送通知
            NSDictionary *userInfo = @{YHUploadOnePicSucessNotificationKey : @(i + 1)};
            [[NSNotificationCenter defaultCenter] postNotificationName:YHUploadOnePicSucessNotification object:nil userInfo:userInfo];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            uploadError(uploadErr);
        });
    });
}

#pragma mark ------------------------------------------
#pragma mark internal methods
/**
 *  OSS同步上传
 *
 *  @param imageData 需要上传的数据
 *  @param imageName 上传的保存子路径
 *
 *  @return 上传错误,有值则说明上传失败
 */
- (NSError *)uploadObjectSync:(NSData *)imageData imageName:(NSString *)imageName{
//#warning 参数设置
    NSString *endpoint = YHOSSEndPoint;  //@"http://img.icgear.net/";
    
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式参考后面链接给出的官网完整文档的`访问控制`章节
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    self.client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    
    // required fields
    put.bucketName = @"icgdb";
    put.objectKey = imageName;
    put.uploadingData = imageData;
    
    // optional fields
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        YHLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    
    OSSTask * putTask = [self.client putObject:put];
    [putTask waitUntilFinished]; // 阻塞直到上传完成
    
    if (!putTask.error) {
        //        YHLog(@"%@ ,upload object success!", imageName);
    } else {
        YHLog(@"%@, upload object failed, error: %@" , imageName, putTask.error);
    }
    return putTask.error;
}

@end
