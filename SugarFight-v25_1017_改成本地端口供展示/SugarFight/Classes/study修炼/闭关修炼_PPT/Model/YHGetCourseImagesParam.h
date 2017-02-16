//
//  YHGetCourseImagesParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/6.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGetCourseImagesParam : NSObject

/** uid 	Integer	用户id	1 */
@property (nonatomic, strong) NSNumber *uid;
/** uuid	String 	用户token	“asdfasf-asdfasf-fgasdf” */
@property (nonatomic, strong) NSString *uuid;
/** courseId	Integer 	课程id	2 */
@property (nonatomic, assign) NSInteger courseId;
@end
