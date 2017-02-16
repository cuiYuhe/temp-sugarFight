//
//  YHChangeIconVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHChangeIconVC.h"
#import "YHSelectIconView.h"
#import "YHChangeAvatarParam.h"
#import "YHChangeAvatarResult.h"
#import <UIImageView+WebCache.h>
#import "YHGetAvatarResult.h"
#import "YHLoginOffVC.h"

static NSString *const strUrlChangeAvatar = @"jianpai/User/updateava";
static NSString *const strUrlGetAvatar = @"jianpai/User/getAva";

@interface YHChangeIconVC ()<YHSelectIconViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet YHSelectIconView *allIconsView;
/** YHChangeAvatarResult */
@property (nonatomic, strong) YHChangeAvatarResult *changeAvaResult;
/** 选择的头像索引 */
@property (nonatomic, assign) NSInteger avatarIndex;
/** 用户是否选择了头像,可能用户直接点击了确定,没有选择头像 */
@property (nonatomic, assign, getter=isPickedAvatar) BOOL pickedAvatar;
/** YHGetAvatarResult */
@property (nonatomic, strong) YHGetAvatarResult *getAvatarResultM;
/** 选中更改的avatar */
@property (nonatomic, strong) UIImage *changedAvatar;

@end

@implementation YHChangeIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    //得到供选择的头像
    [self getAvatarsForChange];
}

- (void)setup{
    self.allIconsView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.avatarUrlString];
    [self.iconImgView sd_setImageWithURL:url];
}

#pragma mark ------------------------------------------
#pragma mark internal methods
//得到供选择的头像
- (void)getAvatarsForChange{
    
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    [YHHttpTool postNotByJSONDataWithUrl:strUrlGetAvatar params:nil success:^(id  _Nonnull responseObj) {
      
        self.getAvatarResultM = [YHGetAvatarResult mj_objectWithKeyValues:responseObj];
        if (self.getAvatarResultM.stuatus.integerValue == 1) {
            self.allIconsView.avas = self.getAvatarResultM.avas;
        }else{
            [MBProgressHUD showError:self.getAvatarResultM.message];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cfmAction:(id)sender {
    
    if (!self.pickedAvatar) { //没有选择头像替换
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    YHChangeAvatarParam *param = [[YHChangeAvatarParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    
    //得到用户选中的avatar的模型中对应的refId
    YHAvasModel *avatar = self.getAvatarResultM.avas[self.avatarIndex];
    param.ava_id = avatar.refId;
    NSDictionary *paramDic = [param mj_keyValues];
    
    [YHHttpTool postByJSONDataWithUrl:strUrlChangeAvatar params:paramDic success:^(id  _Nonnull responseObj) {
        self.changeAvaResult = [YHChangeAvatarResult mj_objectWithKeyValues:responseObj];
        
        if (self.changeAvaResult.stuatus.integerValue == 1) {
            [MBProgressHUD showSuccess:@"更换头像成功."];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [MBProgressHUD showError:@"更换头像失败,请稍后重试."];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}


#pragma mark ------------------------------------------
#pragma mark YHSelectIconViewDelegate
- (void)selectIconViewView:(YHSelectIconView *)iconView didSelectIcon:(UIImage *)icon iconIndex:(NSInteger)index{
    self.iconImgView.image = icon;
    self.avatarIndex = index;
    self.pickedAvatar = YES;
    self.changedAvatar = icon;
    
    //更改loginOff界面的头像:更改再次请求的参数.userAvatarId
    YHAvasModel *ava = self.getAvatarResultM.avas[index];
    [GlobeSingle shareGlobeSingle].loginM.data.user.userAvatarId = ava.refId;
}

@end









