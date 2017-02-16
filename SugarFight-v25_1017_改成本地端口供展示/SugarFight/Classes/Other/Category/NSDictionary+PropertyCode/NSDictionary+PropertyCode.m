//
//  NSDictionary+PropertyCode.m
//  007--Runtime(字典转模型KVC实现)
//
//  Created by Cui yuhe on 15/12/26.
//  Copyright © 2015年 Cui yuhe. All rights reserved.
//

#import "NSDictionary+PropertyCode.h"

@implementation NSDictionary (PropertyCode)

- (void)propertyCode{
    
    NSMutableString *propertyCodes = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;", key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;", key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;", key];
            
            //BOOL类型
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;", key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;", key];
        }
        
        //拼接code
        [propertyCodes appendString:[NSString stringWithFormat:@"\n%@\n", code]];
    }];
    NSLog(@"%@", propertyCodes);
    
    
}
@end
