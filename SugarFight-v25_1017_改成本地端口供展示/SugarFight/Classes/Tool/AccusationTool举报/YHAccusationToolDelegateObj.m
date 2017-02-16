//
//  YHReportToolDelegate.m
//  举报按钮
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAccusationToolDelegateObj.h"
#import "YHAccusationTool.h"
//#import "YHAccuationParam.h"

static NSString *const YHStrUrlAccuse = @"jianpai/Msg/accuse";

@interface YHAccusationToolDelegateObj()<YHAccusationToolDelegate>

@property (nonatomic, strong) YHAccusationTool *accusationTool;
@end

@implementation YHAccusationToolDelegateObj

- (instancetype)init{
    if (self = [super init]) {
        YHAccusationTool *tool = [[YHAccusationTool alloc] init];
        tool.delegate = self;
        self.accusationTool = tool;
    }
    return self;
}

//- (YHAccuationParam *)paramOfAccusation{
//    if (!_paramOfAccusation) {
//        self.paramOfAccusation = [[YHAccuationParam alloc] init];
//    }
//    return _paramOfAccusation;
//}

#pragma mark ------------------------------------------
#pragma mark external method
///举报
- (void)accuseWithVc:(UIViewController *)vc{
    [self.accusationTool accuseWithVc:vc];
}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)sendAccusation{
    NSDictionary *paramDic = [self.paramOfAccusation mj_keyValues];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlAccuse params:paramDic success:^(id  _Nonnull responseObj) {
        
        YHBaseModel *model = [YHBaseModel mj_objectWithKeyValues:responseObj];
        if (model.status.integerValue == 1) {
            [MBProgressHUD showSuccess:@"举报成功."];
        }else{ 
            [MBProgressHUD showError:model.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark YHAccusationToolDelegate
- (void)accusationToolActionDidClick:(YHAccusationTool *)accusationTool accusationType:(YHAccusationType)accusationType{
    
    //当不是选择其它时,将类别发给控制器
    self.paramOfAccusation.msg = self.accusationTool.accusationCauses[accusationType];
    [self sendAccusation];
}

- (void)accusationToolActionDidFinishAccusationOtherText:(YHAccusationTool *)accusationTool accusationCause:(NSString *)text{
    
    self.paramOfAccusation.msg = text;
    [self sendAccusation];
}


@end
