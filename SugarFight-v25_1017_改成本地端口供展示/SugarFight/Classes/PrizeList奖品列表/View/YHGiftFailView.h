//
//  YHGiftFailView.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHGiftFailView;

@protocol YHGiftFailViewDelegate <NSObject>

@optional
- (void)giftFailViewDidClickOnceMore:(YHGiftFailView *)failView;

@end

@interface YHGiftFailView : UIView

/** delegate */
@property (nonatomic, weak) id<YHGiftFailViewDelegate> delegate;
@end
