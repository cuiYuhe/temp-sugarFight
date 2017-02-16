//
//  YHPushSubPINGModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/1.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPushSubPINGModel : NSObject

/************************** 图片评论通知 -------- begin ****************************/
/** imgUrl */
@property (nonatomic, strong) NSString *imgUrl;
/** "imgId":"112159", */
@property (nonatomic, strong) NSNumber *imgId;
/** "category":"2", */
@property (nonatomic, strong) NSNumber *category;
/** "imgTime":"20160729",返回到查看自己上传图片界面时,请求图片的参数 */
@property (nonatomic, copy) NSString *imgTime;
/************************** 图片评论通知 -------- end ****************************/
@end
