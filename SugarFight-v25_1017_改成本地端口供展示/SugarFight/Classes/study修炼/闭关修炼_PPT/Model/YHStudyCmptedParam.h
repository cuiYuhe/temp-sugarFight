//
//  YHStudyCmptedParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHStudyCmptedParam : NSObject

/** uid	Integer	用户id	1 */
@property (nonatomic, strong) NSNumber *uid;
/** uuid	String	用户token */
@property (nonatomic, strong) NSString *uuid;
/** courseId	Integer	课程id	21 */
@property (nonatomic, assign) NSInteger courseId;
@end
