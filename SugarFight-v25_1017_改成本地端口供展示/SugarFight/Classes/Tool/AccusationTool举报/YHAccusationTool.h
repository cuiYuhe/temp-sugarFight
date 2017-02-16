//
//  YHAccusationTool.h
//  举报按钮
//
//  Created by Cui yuhe on 16/6/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHAccusationTool;

typedef NS_ENUM(NSInteger, YHAccusationType) {
    YHAccusationTypeSex,
    YHAccusationTypeAd,
    YHAccusationTypeCheat,
    YHAccusationTypeOther,
};

@protocol YHAccusationToolDelegate <NSObject>

@optional
/**
 *  当点击了对应的举报选项时,触发的方法
 *  @param AccusationType 举报选项.注:点击'其它'时不会调用,其它的处理在AccusationToolActionDidFinishAccusationOtherText方法中
 */
- (void)accusationToolActionDidClick:(YHAccusationTool *)accusationTool accusationType:(YHAccusationType)accusationType;

/**
 *  当用户举报'其它'选项时,输入完毕举报原因,点击'OK'后的操作
 *  @param text       举报原因
 */
- (void)accusationToolActionDidFinishAccusationOtherText:(YHAccusationTool *)accusationTool accusationCause:(NSString *)text;

@end

@interface YHAccusationTool : NSObject
SingleH(AccusationTool)

/** delegate */
@property (nonatomic, weak) id<YHAccusationToolDelegate> delegate;
/** 举报类别 */
@property (nonatomic, strong) NSArray *accusationCauses;

/**
 *  ///弹出警告vc,必须在控制器的didAppear中调用,因为需要弹出alertVc.因为有时候rootVc的view不在最上面,如被其modal的vc覆盖
 *
 *  @param vc 弹出alertVc的vc
 */
- (void)accuseWithVc:(UIViewController *)vc;
@end
