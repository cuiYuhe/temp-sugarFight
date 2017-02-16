//
//  YHUploadActvtyHeaderView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/9.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHGridImagesHeaderView.h"

@interface YHGridImagesHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;

@end

@implementation YHGridImagesHeaderView

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (void)setImgName:(NSString *)imgName{
    _imgName = [imgName copy];
    self.headerImgView.image = [UIImage imageNamed:imgName];
}

@end
