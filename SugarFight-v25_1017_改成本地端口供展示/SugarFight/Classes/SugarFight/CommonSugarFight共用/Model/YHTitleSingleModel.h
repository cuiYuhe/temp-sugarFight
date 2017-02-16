//
//  YHTitleSingleModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHTitleType) {
    
    ///我的称谓_笑傲江湖
    YHTitleTypeAppellation_bcr = 1,
    ///我的称谓_华山论剑
    YHTitleTypeAppellation_battle,
    ///笑傲江湖
    YHTitleTypeBcr_title,
    ///华山论剑|新品上市&新中瓶完美执行
    YHTitleTypeBattle_title,
    ///主页_笑傲江湖
    YHTitleTypeHomepage_bcr,
    ///主页_华山论剑
    YHTitleTypeHomepage_battle,
    ///主页_闭关修炼
    YHTitleTypeHomepage_biguan,
    ///主页_功力指数
    YHTitleTypeHomepage_gongli
    
};

@interface YHTitleSingleModel : NSObject

/**
 "id": 1,
 
 "version": 1,
 "imgUrl": "http://img.icgear.net/title/appellation/t_xiao.png",
 
 },
 */

/** 标题的id */
@property (nonatomic, assign) YHTitleType ID;
/** "code": "appellation_bcr", */
@property (nonatomic, copy) NSString *code;
/** 标题图片路径 */
@property (nonatomic, copy) NSString *imgUrl;
/** "title": "我的称谓_笑傲江湖" */
@property (nonatomic, copy) NSString *title;
/** 版本,版本变化时,表示标题图片有更新 */
@property (nonatomic, strong) NSNumber *version;



@end
