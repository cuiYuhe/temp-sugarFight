//
//  YHUploadCheckModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUploadCheckModel : NSObject

/** stuatus : 0 图片重复; 1 可以上传 */
@property (nonatomic, strong) NSNumber *stuatus;
/** message */
@property (nonatomic, strong) NSString *message;
/** show, 不用 */
@property (nonatomic, strong) NSNumber *show;
@end
