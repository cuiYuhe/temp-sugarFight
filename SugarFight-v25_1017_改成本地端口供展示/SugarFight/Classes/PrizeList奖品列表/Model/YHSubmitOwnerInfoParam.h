//
//  YHSubmitOwnerInfoParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSubmitOwnerInfoParam : NSObject

/** uid	Integer	用户id	1 */
@property (nonatomic, strong) NSNumber *uid;

/** uuid	String	用户token	“asfsa-dfasd-asdf-sdfa” */
@property (nonatomic, copy) NSString *uuid;

/** name	String 	收货人姓名	“张三” */
@property (nonatomic, copy) NSString *name;

/** tel	String	联系电话	“12341231231” */
@property (nonatomic, copy) NSString *tel;

/** address	String 	收货地址	“广州市番禺区” */
@property (nonatomic, copy) NSString *address;

@end
