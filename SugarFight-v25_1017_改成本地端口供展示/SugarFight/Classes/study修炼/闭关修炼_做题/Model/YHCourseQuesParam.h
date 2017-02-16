//
//  YHCourseQuesParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/7.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCourseQuesParam : NSObject

/** uid	Integer	用户id	1 */
@property (nonatomic, strong) NSNumber *uid;
/** uuid	String	用户token	“asdas-asasdf-asfasdf” */
@property (nonatomic, copy) NSString *uuid;
/**  courseId	Integer	课程id	2 */
@property (nonatomic, strong) NSNumber *courseId;
@end
