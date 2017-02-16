//
//  YHPostCmtParam.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/8.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPostCmtParam : NSObject

/** category:1 */
@property (nonatomic, strong) NSNumber *category;
/** imgId:123, */
@property (nonatomic, strong) NSNumber *imgId;
/**  imgUrl:"http://sdfsfds.jsp", */
@property (nonatomic, strong) NSString *imgUrl;
/**  uid:"23", */
@property (nonatomic, strong) NSNumber *uid;
/** token:"assdfs342sdfs", */
@property (nonatomic, strong) NSString *token;
/**  ping:"评论1 */
@property (nonatomic, strong) NSString *ping;

@end
