//
//  YHUploadActvtyCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/9.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHGridImagesCell;

@protocol YHGridImagesCellDelegate <NSObject>

@optional
- (void)gridImagesCell:(YHGridImagesCell *)cell didFinishDownloadImage:(UIImage *)image imageStringUrl:(NSString *)stringUrl;

@end

@interface YHGridImagesCell : UICollectionViewCell

/** 标题:图片名称 */
@property (nonatomic, strong) UIImage *imageToShow;
/** picImgView,子类需要自己添加到picImgView,因为有的类不同 */
@property (nonatomic, weak) UIImageView *picImgView;
/** delegate */
@property (nonatomic, weak) id<YHGridImagesCellDelegate> delegate;


- (void)setup;
///得到其中显示图片的imageView的frame,需在layoutSubView中调用
- (CGRect)getFrameOfPicImageView;

+ (NSString *)identifier;
@end
