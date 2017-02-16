//
//  YHCustomSSImgModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 自定义swordSong的cell的model.因为后台返回数据不可复用  */
@interface YHCustomSSImgModel : NSObject
/** 图片地址 */
@property (nonatomic, copy) NSString *imgUrl;
/** 有无图片地址,因为没有地址后台返回空 */
@property (nonatomic, assign, getter=isHaveImg) BOOL haveImg;
/** 缓存的图片,如果有的话就不用下载 */
@property (nonatomic, strong) UIImage *imageCached;
@end
