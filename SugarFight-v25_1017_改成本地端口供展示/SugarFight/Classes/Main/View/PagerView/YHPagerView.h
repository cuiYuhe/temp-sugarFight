//
//  YHPagerView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/17.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPagerView;

@protocol YHPagerViewDelegate <NSObject>

@optional
///最后一个界面有没有完成按钮
- (UIButton *)pagerViewShouldHaveFinishBtnAtLastIndexPath:(YHPagerView *)pagerView;

///点击了finishBtn
- (void)pagerViewDidClickFinishBtn:(YHPagerView *)pagerView;

///滑到了第pagerIndex引导页
- (void)pagerView:(YHPagerView *)pagerView didTurnToPagerIndex:(NSInteger)pagerIndex;

///有弹性时,滑过了最后一张
- (void)pagerViewDidFinishTurnOverAllPages:(YHPagerView *)pagerView;
@end

@interface YHPagerView : UIView


/** 展示的views数组,因为有些是图片,有的不是图片 */
@property (nonatomic, strong) NSArray<UIView *> *showViews;
/** delegate */
@property (nonatomic, weak) id<YHPagerViewDelegate> delegate;


@end
