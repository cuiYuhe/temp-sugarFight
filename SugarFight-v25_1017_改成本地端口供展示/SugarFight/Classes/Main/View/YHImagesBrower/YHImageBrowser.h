//
//  YHImagesBrower.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHDownloadImageView, YHImageBrowser;

@protocol YHImageBrowserDelegate <NSObject>

@required
/**
 *  初始时的位置,切换到第几个image
 */
- (NSInteger)imageBrowserStartIndex:(YHImageBrowser *)imageBrower;

@end

///目前封装的比较简单,因为没有小图片,只要赋值图片就可以了.之后应该需要优化.
@interface YHImageBrowser : UIView

/** YHDownloaderImageViews,因为现在外界已经有了,直接传进来就可以了,进度什么的都不用设置 */
@property (nonatomic, strong) NSArray<YHDownloadImageView *> *imageViews;

+ (__kindof YHImageBrowser *)imageBrowser;
@end
