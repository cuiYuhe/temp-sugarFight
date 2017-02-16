//
//  YHGetImageModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetImageModel : NSObject

/** imgBiao = 0 */
@property (nonatomic, strong) NSNumber *imgBiao;
/** imgCategoryId = 1 */
@property (nonatomic, strong) NSNumber *imgCategoryId;
/** imgId = 270 */
@property (nonatomic, strong) NSNumber *imgId;
/** imgMd5,目前为空 */
@property (nonatomic, copy) NSString *imgMd5;
/** imgScore = 0 */
@property (nonatomic, strong) NSNumber *imgScore;
/** imgUpdatetime = 20160603 */
@property (nonatomic, strong) NSString *imgUpdatetime;
/** imgUrl */
@property (nonatomic, strong) NSString *imgUrl;
/**  imgUserId = 22 */
@property (nonatomic, strong) NSNumber * imgUserId;
/**  pid = 6 */
@property (nonatomic, strong) NSNumber * pid;
@end
