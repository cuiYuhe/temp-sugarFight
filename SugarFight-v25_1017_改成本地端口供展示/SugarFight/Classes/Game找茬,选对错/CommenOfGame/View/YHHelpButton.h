//
//  YHHelpButton.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/2.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHHelpInfoParam;

typedef NS_ENUM(NSInteger, YHShowHelpImagesType){
    /** 显示helpImages */
    YHShowHelpImagesTypeAlways,
    /** 根据服务器确定,是否显示helpImages */
    YHShowHelpImagesTypeLetsSee,
    /** 不显示helpImages */
    YHShowHelpImagesTypeNo,
};

@interface YHHelpButton : UIButton

/** YHHelpInfoParam */
@property (nonatomic, strong) YHHelpInfoParam *paramOfHelpInfo;
/** <#注释#> */
@property (nonatomic, assign) YHShowHelpImagesType showHelpImages;


/**
 *  在vc中,按钮被点击时调用此方法
 *
 *  @param isShowHelp YES表示当前vc需要显示帮助引导页
 */
//- (void)clickWithShowHelp:(BOOL)isShowHelp;
@end
