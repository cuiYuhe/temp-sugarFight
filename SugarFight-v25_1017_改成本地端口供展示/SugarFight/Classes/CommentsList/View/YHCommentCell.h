//
//  YHCommentsCell.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHCommentModel, YHCommentCell, YHCommentsListVC;

@protocol YHCommentCellDelegate <NSObject>

@optional
- (void)commentCellDidDingComment:(YHCommentCell *)cell totalDings:(NSNumber *)dings;

@end

@interface YHCommentCell : UITableViewCell
/** comt */
@property (nonatomic, strong) YHCommentModel *comment;
/** delegate */
@property (nonatomic, weak) id<YHCommentCellDelegate> delegate;
/** YHCommentsListVC, 用来modal出alertVc */
@property (nonatomic, weak) UIViewController *cmtVc;

+ (NSString *)identifier;

@end
