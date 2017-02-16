//
//  YHCommentModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/16.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSInteger const YHTextFont = 12;
static NSInteger const YHNameFont = 14;

@interface YHCommentModel : NSObject

/** 图片的类别,0完美; 1bcr */
@property (nonatomic, strong) NSNumber *pingCategory;
/** 评论表id */
@property (nonatomic, strong) NSNumber *pingId;
/** 评论的图片id */
@property (nonatomic, strong) NSNumber *pingIid;

/** pingPushed = 3;  评论点赞数 */
@property (nonatomic, strong) NSNumber *pingPushed;
/** pingUid = 13; 评论的用户id */
@property (nonatomic, strong) NSNumber *pingUid;

/*************************** 文字/图片数据 ********************/
/** userAvatar 头像"; */
@property (nonatomic, strong) NSString *userAvatar;
/** userName = "\U5f209"; */
@property (nonatomic, strong) NSString *userName;

/** 职位 */
@property (nonatomic, copy) NSString *userJobTitle;

/** pingLun = asdgwdgsd; 评论内容 */
@property (nonatomic, strong) NSString *pingLun;


/************************* frame 数据 *****************************/
/** 图像的frame */
@property (nonatomic, assign)CGRect iconFrame;

/** 昵称的frame */
@property (nonatomic, assign)CGRect nameFrame;
/** 举报按钮的frame */
@property (nonatomic, assign) CGRect accusFrame;

/** zanBtn的frame*/
@property (nonatomic, assign)CGRect zanBtnFrame;
/** jobTitleFrame的frame*/
@property (nonatomic, assign)CGRect jobTitleFrame;

/** 内容的frame */
@property (nonatomic, assign)CGRect textFrame;

/** 配图的frame */
@property (nonatomic, assign)CGRect bgImgViewFrame;
/** cell的高度 */
@property (nonatomic ,assign)CGFloat cellHeight;
/** cell的宽度 */
@property (nonatomic ,assign)CGFloat cellWidth;


@end
