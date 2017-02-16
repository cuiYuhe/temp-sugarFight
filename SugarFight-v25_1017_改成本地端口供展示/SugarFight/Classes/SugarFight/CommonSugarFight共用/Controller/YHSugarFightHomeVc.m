//
//  YHSugarFightHomeVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHSugarFightHomeVc.h"
#import "YHBaseParam.h"
#import "YHFileTool.h"
#import <UIImageView+WebCache.h>

///获取标题图片列表
static NSString *const YHStrUrlAllTitles = @"jianpai/Msg/getTitleMsgList";

@interface YHSugarFightHomeVc ()

@end

@implementation YHSugarFightHomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadAllTitlesWithSuccess:(void (^)(YHTitlesResult *titlesM))success failure:(void (^)(NSError * error))failure{
    //1.加载所有的标题
    YHBaseParam *param = [[YHBaseParam alloc] init];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlAllTitles params:[param mj_keyValues] success:^(id  _Nonnull responseObj) {
        
        YHTitlesResult *titles = [YHTitlesResult mj_objectWithKeyValues:responseObj];
        
        if (titles.status.integerValue == 1) {
            [GlobeSingle shareGlobeSingle].titlesM = titles;
            
            //判断是否需要保存模型:YHTitlesResult
            [self checkIfSaveTitles:titles];
            
            !success ? : success(titles);
            
        }else{
            [MBProgressHUD showError:titles.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"加载标题数据失败!"];
        !failure ? : failure(error);
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark private method
///判断是否需要保存模型:YHTitlesResult
- (void)checkIfSaveTitles:(YHTitlesResult *)titles{
    //读取归档
    YHTitlesResult *savedTitles = (YHTitlesResult *)[YHFileTool readModelWithFileName:YHArchiveTitlesFileName];
    
    if (savedTitles) {//已经保存过模型
        
        BOOL isUpdateSavedModel = NO; //需要更新保存的模型标志
        NSInteger loadCount = titles.titleMsgs.count;
        NSInteger savedCount = savedTitles.titleMsgs.count;
        for (NSInteger i = 0; i < loadCount; i++) {
            
            if (savedCount >= i) { //保存个数的数量足够.防止保存的个数少,导致数组越界
                YHTitleSingleModel *loadTitleM = titles.titleMsgs[i];
                
                YHTitleSingleModel *savedTitleM = savedTitles.titleMsgs[i];
                if (![loadTitleM.version isEqualToNumber:savedTitleM.version]) {//如果不相等,需要更新图片.删除sdWebImage保存的图片
                    [[SDImageCache sharedImageCache] removeImageForKey:savedTitleM.imgUrl];
                    isUpdateSavedModel = YES; //版本已改变,需要重新保存模型
                }
            }
        }
        
        if (isUpdateSavedModel) {//需要更新保存的模型,则重新保存
            //归档保存
            [YHFileTool saveModel:titles fileName:YHArchiveTitlesFileName];
        }
        
    }else{//没有保存过模型.
        //归档保存
        [YHFileTool saveModel:titles fileName:YHArchiveTitlesFileName];
    }
}


@end
