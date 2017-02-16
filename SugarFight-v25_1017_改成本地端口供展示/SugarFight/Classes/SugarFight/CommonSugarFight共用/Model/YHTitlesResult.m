//
//  YHTitlesResult.m
//  SugarFight
//
//  Created by Cui yuhe on 16/8/30.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHTitlesResult.h"
#import "UIImageView+Extension.h"
#import "YHLoginModel.h"

@implementation YHTitlesResult
MJCodingImplementation


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"titleMsgs" : [YHTitleSingleModel class]};
}

// 设置titleImageView的标题图片
- (void)setTitleImageWithTitleType:(YHTitleType)titleType titleImageView:(UIImageView *)imageView{
    
    if (YHAccountOfApple) {
        imageView.image = [UIImage imageNamed:@"title_Fighting"];
        return;
    }
    NSString *strUrl = nil;
    for (YHTitleSingleModel *titleM in self.titleMsgs) {
        if (titleM.ID == titleType) {
            strUrl = titleM.imgUrl;
        }
    }
    
    if (strUrl) {
        [imageView yh_setImageWithURLString:strUrl imageName:@"title_placeholder"];
    }else{
        YHLog(@"titleType = %zd的图片没找到", titleType);
    }
}

@end
