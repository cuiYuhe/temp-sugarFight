//
//  YHGetDaysListParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHGetDaysListParam : NSObject

/**  uid	Integer	用户id	1 */
@property (nonatomic, strong) NSNumber *uid;
/**  uuid	String	用户token	"asfasdfa-asdfaaf-asdfq41-asdf" */
@property (nonatomic, strong) NSString *uuid;
/**  category 请求照片类型	.0：华山论剑（1-3张); 1：笑傲江湖（2张） */
@property (nonatomic, strong) NSNumber *category;
@end
