//
//  YHCommentsListVC.h
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHTriggeredByNoteVc.h"
@class YHCommentsListParam, YHPostCmtParam;


@interface YHCommentsListVC : YHTriggeredByNoteVc
/** YHCommentParam, 由来源vc赋值 */
@property (nonatomic, strong) YHCommentsListParam *getCommentparam;
/** YHPostCmtParam, 由来源vc赋值,其中的评论内容由当前vc赋值. */
@property (nonatomic, strong) YHPostCmtParam *postCmtParam;
/** 是否隐藏文字输入框 */
@property (nonatomic, assign, getter=isHideCmtField) BOOL hideCmtField;

/****************************** 通知相关属性 --- begin  **************************/


/** 远程通知的标志,只使用一次,使用过之后就设置为No.用来向图片vc传pushM,保证一次远程通知只传一次,下次再从当前vc到图片vc时,不再传值. */
@property (nonatomic, assign, getter=isDisposableNoteTag) BOOL disposableNoteTag;

/****************************** 通知相关属性 --- end  **************************/

@end
