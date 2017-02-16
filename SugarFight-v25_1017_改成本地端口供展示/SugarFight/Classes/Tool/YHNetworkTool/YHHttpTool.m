//
//  YHHttpTool.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/26.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHHttpTool.h"
#import <AFNetworking/AFNetworking.h>

//本地地址：192.168.1.?:8888/jianpai
/** 服务器,为了可以修改,没用const修饰 */
//static NSString * YHBaseUrlStr = @"http://120.24.218.154:8080/";

/** 供测试 */
static NSString * YHBaseUrlStr = @"http://120.24.218.154:8888/";
/** 理政 */
//static NSString * YHBaseUrlStr = @"http://192.168.1.162:8080/";
//static NSString *const YHBaseUrlStr = @"http://192.168.1.134:8080/";
/** 城霖 */
//static NSString *const YHBaseUrlStr = @"http://192.168.1.121:8080/";

///下载图片成功接口
static NSString *const YHStrUrlDownloadImgSuccess = @"jianpai/Img/downloadsuccess";

@implementation YHHttpTool
SingleM(HttpTool)

static AFHTTPSessionManager *_manager;
///test时的url地址
static NSString *_testClassBaseUrl;

+ (AFHTTPSessionManager *)manager{
    if (!_manager) {
        
        NSString *baseStrUrl = YHBaseUrlStr;
#if DEBUG
        //test的时候,可以切换后台地址,默认是本地
//        baseStrUrl = @"http://192.168.1.162:8080/";
        baseStrUrl = @"http://120.24.218.154:8888/";
        if (_testClassBaseUrl) {
            baseStrUrl = _testClassBaseUrl;
        }
#endif
        
        NSURL *baseUrl = [NSURL URLWithString:baseStrUrl];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    return _manager;
}

//为测试时的url
- (void)setTestBaseUrl:(NSString *)testBaseUrl{
    _testBaseUrl = [testBaseUrl copy];
    _testClassBaseUrl = testBaseUrl;
    _manager = nil;
}

#pragma mark ------------------------------------------
#pragma mark external method
+ (void)informServerDownloadImgSuccess{
//    [[self manager] POST:YHStrUrlDownloadImgSuccess parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YHLog(@"download img success");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        YHLog(@"download img failure");
//    }];
    //用AFN请求,走的是failure回调,不知何故
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", YHBaseUrlStr, YHStrUrlDownloadImgSuccess];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *r = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:r queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            YHLog(@"inform server failed");
        }else{
//            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            YHLog(@"inform server success: return Str = %@", string);
        }
    }];
}

+ (void)postByJSONDataWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    
    if (!params) {
        YHLog(@"parames不能为空!");
        return;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *paramsJson = @{@"params" : str};
//    YHLog(@"paramsJson = %@", paramsJson);
    
    [[self manager] POST:url parameters:paramsJson progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/// POST请求,不用序列化成data
+ (void)postNotByJSONDataWithUrl:(NSString *)url params:(NSDictionary *_Nullable)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    
    YHLog(@"baseUrl = %@", [self manager].baseURL);
    [[self manager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/// GET请求,不用序列化成data
+ (void)getNotByJSONDataWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    
    [[self manager]GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)checkMd5IsExistTestSync:(NSString *)md5{
    NSString *strUrl = @"jianpai/Img/bmd";
    NSDictionary *param = @{@"md" : md5};
    [self PostRequestSyncWithUrlString:strUrl parameters:param];
}

///检验md5是否存在
+ (void)checkMd5IsExist:(NSString *)md5Param success:(void(^)(id responseObj))success
                failure:(void(^)(NSError * _Nonnull error))failure;{
    
    NSString *strUrl = @"jianpai/Img/bmd";
    NSDictionary *paramDic = [md5Param mj_keyValues];
    
    [self postNotByJSONDataWithUrl:strUrl params:paramDic success:^(id  _Nonnull responseObj) {
        
        success(responseObj);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
//    NSDictionary *dic = [self PostRequestSyncWithUrlString:strUrl parameters:param];
//    YHLog(@"dic = %@", dic);
}

///取消所有请求
+ (void)cancelAllTasks{
    [[self manager].operationQueue cancelAllOperations];
}










#pragma mark ------------------------------------------
#pragma mark 同步方法,待完善
+ (void)checkSyncMd5IsExist:(NSString *)md5
{
    NSString *strUrlPart = @"jianpai/Img/bmd";
//    NSString *strUrlPart = @"jianpai/Img/bmd_json_string";
    
    
    //1.确定请求路径
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?md=%@", YHBaseUrlStr, strUrlPart, md5];
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    //2.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //3.修改请求方法为POST(大写)
//    request.HTTPMethod = @"POST";
    
    //4.设置请求体
//    request.HTTPBody = [@"username=dede&pwd=ede&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = [[NSString stringWithFormat:@"md=%@", md5] dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求头信息
//    [request setValue:@"ios 9.0" forHTTPHeaderField:@"User-Agent"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求超时
//    request.timeoutInterval = 10;
    
    //5.发送POST请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //6.解析数据
        if (connectionError == nil) {
            NSLog(@"%@---%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],[NSThread currentThread]);
        }
    }];
    
    NSError *error = nil;
    NSData * returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (error) {
        YHLog(@"testSyncError = %@", error);
        return;
    }
    NSString *returnStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    YHLog(@"returnStr = %@", returnStr);
    NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingAllowFragments error:&error];
    YHLog(@"returnDic = %@", returnDic);
    
    if (error) {
        YHLog(@"testSyncError = %@", error);
    }else{
        YHLog(@"returnDic = %@", returnDic);
    }
}

///同步请求
+ (NSDictionary *)PostRequestSyncWithUrlString:(NSString *)urlString parameters:(NSDictionary *)dic{
    
    // 初始化请求
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", YHBaseUrlStr, urlString];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    // 2.设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField: @"Content-Type"];

    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:data];
    
    // 发送同步请求, data就是返回的数据
    NSError *error = nil;
    
    NSData * returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error]
    ;
    NSDictionary *returnDic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
    
    return returnDic;
}


+(void)sendRequestSyncWithUrlString:(NSString*)urlString parameters:(NSDictionary*)dic Success: (void(^)( NSDictionary* _Nullable returnDic))success Failure:(void (^)(NSError * _Nullable error))failure
{
    YHLog(@"thread = %@", [NSThread currentThread]);
    NSURLSession * _session = [NSURLSession sharedSession];
    
    NSString * urlstring2 =[NSString stringWithFormat:@"%@?%@",urlString,[self dicString:dic]];
    
    NSURLSessionDataTask * dataTask = [_session dataTaskWithURL:[NSURL URLWithString:urlstring2] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
       {
           if (!error) {
               // 响应状态代码为200，代表请求数据成功，判断成功后我们再进行数据解析
               NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
               if (httpResp.statusCode == 200){
                   //                NSError *jsonError;
                   //解析NSData数据
                   NSDictionary * dic = [self JSONDictionaryWithData:data];
                   
                   success(dic);
                   
               }
           }
           else{
               failure(error);
           }
           
       }];
    
    [dataTask resume];
    
    
}

///不是AFN,同步请求,成功,无回调
+ (NSDictionary*)sendRequestSyncWithUrlString:(NSString*)urlString parameters:(NSDictionary*)dic
{
    //   NSURLSession * _session = [NSURLSession sharedSession];
    
#warning 自己将下面一句替换为再下面一句
//        NSString * urlstring2 =[NSString stringWithFormat:@"%@%@?%@", YHBaseUrlStr, urlString,[self dicString:dic]];
    
    NSString * urlstring2 = [NSString stringWithFormat:@"%@%@", YHBaseUrlStr, urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlstring2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField: @"Content-Type"];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    NSError *error = nil;
    
    NSData * returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error]
    ;
    
    NSDictionary *returnDic = [[NSDictionary alloc]init];
    
    if (data){
        returnDic = [self JSONDictionaryWithData:returnData];
    }
    return returnDic;
}

+ (NSString *)dicString:(NSDictionary *)dic
{
    NSString *requestion = @"";
    
    NSInteger i = 0;
    
    for (NSString * key in dic.allKeys)
    {
        NSString *requestkey = [NSString stringWithFormat:@"%@=%@%@",key,dic[key],i == dic.allKeys.count - 1 ? @"" : @"&"];
        
        requestion = [requestion stringByAppendingString:requestkey];
        
        i++;
    }
    
    return requestion;
}

+(id)JSONDictionaryWithData:(NSData*) data
{
    if(![data isKindOfClass:[NSData class]])
        return nil;
    
    NSError *error = nil;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error)
    {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSLog(@"%@",error);
    }
    
    if([dic isKindOfClass:[NSDictionary class]])
    {
        return dic;
    }
    
    return nil;
}








@end
