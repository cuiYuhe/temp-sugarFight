//
//  YHPrizeSubReceiverModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPrizeSubReceiverModel : NSObject
//receiver =     {
//    address = "\U4e2d\U56fd\U5e7f\U4e1c";
//    id = "<null>";
//    name = "\U771f\U6b63\U7684\U4eba";
//    tel = 12345678910;
//    uid = 6;
//};


/** 收货人地址信息 */
@property (nonatomic, copy) NSString *address;
/** <#注释#> */
@property (nonatomic, strong) NSNumber *ID;
/** 收货人姓名 */
@property (nonatomic, copy) NSString *name;
/** 收货人电话 */
@property (nonatomic, copy) NSString *tel;
/** <#注释#> */
@property (nonatomic, strong) NSNumber *uid;


/******************** 添加的属性 *****************************/
/** 礼品名称,在 YHShakePrizeResult 类中重写gift属性的set方法赋的值*/
@property (nonatomic, copy) NSString *giftName;
@end
