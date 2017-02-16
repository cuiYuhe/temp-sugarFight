//
//  YHBaseParam.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/29.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHBaseParam.h"

@implementation YHBaseParam

- (NSNumber *)uid{
    return [GlobeSingle shareGlobeSingle].userID;
}

- (NSString *)uuid{
    return [GlobeSingle shareGlobeSingle].uuid;
}
@end
