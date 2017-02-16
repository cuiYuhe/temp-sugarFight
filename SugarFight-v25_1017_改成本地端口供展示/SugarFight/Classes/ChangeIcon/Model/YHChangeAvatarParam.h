//
//  YHChangeAvatarParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/5/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHChangeAvatarParam : NSObject

/**  "uid": "4" */
@property (nonatomic, strong) NSNumber *uid;
/** "source": "ios", */
@property (nonatomic, strong) NSString *source;
/**  "uuid": "a5e433ac-129f-11e6-821e-c860009ce94c", */
@property (nonatomic, strong) NSString *uuid;
/**  "ava_id": "2",得到头像时avatarModel中的refId */
@property (nonatomic, strong) NSNumber *ava_id;


@end
