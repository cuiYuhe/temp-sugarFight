//
//  YHCommentModel.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommentModel.h"

@implementation YHCommentModel

//test,为了有jobTitle
//- (void)setUserName:(NSString *)userName{
//    _userName = [userName copy];
//    _userJobTitle = @"月老的徒弟";
//}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        
        CGFloat margin = 5;
        
        //1.icon
        CGFloat iconX = margin;
        CGFloat iconY = margin;
        CGFloat iconW = 40;
        CGFloat iconH = 40;
        self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
        
        //2.zanButton
        CGFloat zanBtnW = 80;
        NSDictionary *nameAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:YHNameFont]};
//        CGSize zanBtnSize = [self.userName sizeWithAttributes:nameAttr];
//        CGFloat zanBtnH = zanBtnSize.height;
        //margin由nameLabel与JobTitleLabel各一半
        CGFloat zanBtnH = (iconH - margin) / 2;
        CGFloat zanBtnX = self.cellWidth - zanBtnW - margin;
        CGFloat zanBtnY = margin;
        self.zanBtnFrame = CGRectMake(zanBtnX, zanBtnY, zanBtnW, zanBtnH);
        
        //3.accusBtn
        CGFloat accusW = 50;
        CGFloat accusH = zanBtnH;
        CGFloat accusX = CGRectGetMinX(self.zanBtnFrame) - accusW - margin;
        CGFloat accusY = zanBtnY;
        self.accusFrame = CGRectMake(accusX, accusY, accusW, accusH);
        
        //4.nameLabel
        CGFloat nameX = CGRectGetMaxX(self.iconFrame) + margin;
        CGFloat nameY = iconY;
        CGFloat nameH = zanBtnH;
//        CGFloat nameW = self.cellWidth - nameX - zanBtnW - 2 * margin;
        CGFloat nameW = CGRectGetMinX(self.accusFrame) - nameX - margin;
        self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
        
        //5.jobTitle
        CGFloat jobTitleX = nameX;
        CGFloat jobTitleW = self.cellWidth - jobTitleX - margin;
        CGFloat jobTitleH = nameH;
        CGFloat jobTitleY = CGRectGetMaxY(self.iconFrame) - jobTitleH;
        self.jobTitleFrame = CGRectMake(jobTitleX, jobTitleY, jobTitleW, jobTitleH);
        
        //5..textLabel
        CGFloat textX = iconX;
        CGFloat textY = CGRectGetMaxY(self.iconFrame) + margin;
        CGFloat textW = self.cellWidth - textX - margin;
        NSDictionary *textAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:YHTextFont]};
        CGFloat textH = [self.pingLun boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height + margin;
        self.textFrame = CGRectMake(textX, textY, textW, textH);
        
        _cellHeight = CGRectGetMaxY(self.textFrame) + margin;
        
        //5.bgImgView
        self.bgImgViewFrame = CGRectMake(0, 0, self.cellWidth - 2, _cellHeight);
        
    }
    return _cellHeight;
}


@end
