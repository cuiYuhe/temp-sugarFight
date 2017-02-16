//
//  YHStudyListCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHStudyListCell.h"
#import "YHCourseModel.h"

@interface YHStudyListCell()
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation YHStudyListCell

- (void)awakeFromNib{
    [self setup];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.courseNameLabel.textColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (void)setCourse:(YHCourseModel *)course{
    _course = course;
    self.courseNameLabel.text = course.courseName;
    if (course.courseScore == -1) {
        self.scoreLabel.text = [NSString stringWithFormat:@"无得分记录."];
    }else{
        self.scoreLabel.hidden = NO;
        self.scoreLabel.text = [NSString stringWithFormat:@"得分: %zd", course.courseScore];
    }
}

@end
