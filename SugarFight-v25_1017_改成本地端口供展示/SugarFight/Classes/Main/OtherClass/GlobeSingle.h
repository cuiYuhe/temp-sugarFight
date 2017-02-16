//
//  GlobeSingle.h
//  IceManInMay
//
//  Created by Cui yuhe on 16/4/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHLoginModel, YHTitlesResult;

typedef NS_ENUM(NSInteger, YHUserType){
    YHUserTypeCommonWS, //普通用户
    YHUserTypeCommonNotWS, //普通用户
    YHUserTypeVipNation, //全国vip
    YHUserTypeVipDistrict, //大区vip
    YHUserTypeVipProvince,
    YHUserTypeVipCity,
};

/** 请求参数/ 0:论剑; 1:bcr; 2:battle  */
typedef NS_ENUM(NSInteger, YHCategoryType){
    
    /** 0:论剑*/
    YHCategoryTypeHuaShanPerfect = 0,
    /** 1:bcr */
    YHCategoryTypePrideBcr,
    /** 2,battle */
    YHCategoryTypeBattleGridImages
};

@interface GlobeSingle : NSObject
SingleH(GlobeSingle)

/** uuid 用户的uuid，这个uuid是登录的时候返回的message, 如:"a5e433ac-129f-11e6-821e-c860009ce94c"*/
@property (nonatomic, strong) NSString *uuid;

/** 用户的id,loginM.data.user.userID */
@property (nonatomic, strong) NSNumber *userID;
/** avatar,更改头像成功后,返回到这个界面时,要显示这个头像,如果接口完善的话,就不用这个属性了,直接再次请求 */
//@property (nonatomic, strong) UIImage *changedAvatar;
/** 当用户第一次登录,修改过密码之后跳转到注销界面,注销界面需要此model */
@property (nonatomic, strong) YHLoginModel *loginM;
/** 所有的标题模型 */
@property (nonatomic, strong) YHTitlesResult *titlesM;

/** 用户类型 */
@property (nonatomic, assign) YHUserType userType;
/** 修炼模块-题目的tableView的宽度,用来计算cell的宽度. */
@property (nonatomic, assign) CGFloat tableViewWidthOfExercise;

/** 点击远程通知启动app时,远程通知的信息.在loginVc时据此判断跳转的界面 */
@property (nonatomic, strong) NSDictionary *remoteNote;


/**
 *  确定是什么用户类型:普通或vip,以及什么普通,什么vip
 *
 *  @return 根据用户类型,跳转的目的vc
 */
- (UIViewController *)findWhatUserType;

///根据sbName,得到sb控制器
- (__kindof UIViewController *)vcWithSbName:(NSString *)sbName;

///在控制器都是modal出来时(没有nav与tabBar),得到用户能看到的vc
- (UIViewController *)getTopVc;
@end
