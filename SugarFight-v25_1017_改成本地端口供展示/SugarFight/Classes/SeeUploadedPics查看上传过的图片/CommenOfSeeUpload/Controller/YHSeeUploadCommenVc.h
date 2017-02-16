//
//  YHSeeUploadCommenVc.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/20.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHViewController.h"
#import "YHGetDaysListResult.h"
#import "YHCommentsListVC.h"
#import "YHCommentsListParam.h"
#import "YHGetImgListResult.h"
#import "YHGetDaysListParam.h"
#import "YHGetImgListParam.h"
#import "YHDateTool.h"
#import "SDWebImageOperation.h"
#import "YHPopAllScreenImageView.h"
#import "YHPushModel.h"
#import "YHTriggeredByNoteVc.h"

@interface YHSeeUploadCommenVc : YHTriggeredByNoteVc

/**************************** 字类继承属性 - begin ******************************/
/** YHGetDaysListResult model */
@property (nonatomic, strong) YHGetDaysListResult *daysListM;
/** 查询图片时,哪天的索引,越界时(小于0,或大于总数)没有图片,不能查询 */
@property (nonatomic, assign) NSInteger dayIndex;
/** YHGetImgListResult model */
@property (nonatomic, strong) YHGetImgListResult *ImgListM;
/** images字典,缓存使用: stringUrl : image */
@property (nonatomic, strong) NSMutableDictionary *imagesDic;

/**************************** 字类继承属性 - end ******************************/


/**************************** 外界赋值 - begin ******************************/
/** 用户由远程通知到commentVc,再返回到看图片界面时,通知给的信息 */


/**************************** 外界赋值 - end ******************************/








#pragma mark ------------------------------------------
#pragma mark 子类实现方法
///继承者必须实现方法,返回YHCategoryType,以网络请求
- (YHCategoryType)categoryType;

///加载照片的日期数据,并加载图片.在父类这里声明的目的,是为了远程通知时,重新请求数据,由父类统一调用.
- (void)getDaysList;



#pragma mark ------------------------------------------
#pragma mark 子类调用方法
/**
 *  提示用户当前日期有无图片,左右切换查看图片时调用.
 *
 *  @param btn 左右切换按钮的tag,必须是10,11
 *  @return yes表示有图片
 */
- (BOOL)isHavePicWithShiftBtn:(UIButton *)btn;

/**
 *  查看评论事件
 */
- (void)seeCmtsAction;

///加载照片的日期数据
- (void)getDaysListWithSuccess:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  准备获得上传图片的请求参数
 *  @param date 请求图片日期
 *  @return 网络请求的参数
 */
- (NSDictionary *)setupParamForImgListWithDate:(NSString *)date;

///设置指定YHPopAllScreenImageView的image
- (void)setImageToImgView:(NSString *)urlStr imageViewToSet:(YHPopAllScreenImageView *)imgV;

///加载到imgList之后的操作
- (void)setupAfterLoadImgList;

///点击返回的vc跳转操作
- (void)backToLastVc;



@end
