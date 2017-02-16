//
//  YHCommentsCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/5.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCommentCell.h"
#import "UIImage+Extension.h"
#import "YHCommentModel.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Extension.h"
#import "YHZanCommentParam.h"
#import "YHZanCommentResult.h"
#import "YHPopNoZanView.h"
#import "YHAccusationBtn.h"
#import "YHIndentLabel.h"

static NSString *const YHStrUrlDingComment = @"jianpai/Score/ding";
static CGFloat const YHAccusBtnFont = 14.0f;
static CGFloat const YHJobTitleFont = 12.0f;

@interface YHCommentCell()
/** bg */
@property (nonatomic, weak) UIImageView *bgImgView;
/** iconImgView */
@property (nonatomic, weak) UIImageView *iconImgView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *zanButton;
/**  */
@property (nonatomic, strong) UILabel *text_label;
/** 举报按钮 */
@property (nonatomic, weak) YHAccusationBtn *accusBtn;
/** 职称,如西区发展部总监 */
@property (nonatomic, weak) UILabel *jobTitleLabel;
@end

@implementation YHCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //0.背景
        UIImageView *bgIv = [[UIImageView alloc] init];
        UIImage *img = [UIImage yh_resizableImage:@"bg_edit"];
        bgIv.image = img;
        bgIv.alpha = 0.5;
        self.bgImgView = bgIv;
        [self.contentView addSubview:bgIv];
        
        //1.icon
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.iconImgView = icon;
        
        //2 昵称label
        YHIndentLabel *nameLabel = [[YHIndentLabel alloc] init];
        nameLabel.backgroundColor = YHrgbColorWithAlpha(0, 0, 0, 0.4);
        nameLabel.textColor = [UIColor whiteColor];

        [self.contentView addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:YHNameFont];
        self.nameLabel = nameLabel;
        
        //3.举报按钮
        YHAccusationBtn *accusBtn = [YHAccusationBtn buttonWithType:UIButtonTypeCustom];
        accusBtn.titleLabel.font = [UIFont systemFontOfSize:YHAccusBtnFont];
        [accusBtn setNormalTitle:@"举报"];
        [self.contentView addSubview:accusBtn];
        self.accusBtn = accusBtn;
        [accusBtn addTarget:self action:@selector(accuseClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //4.赞的按钮
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setImage:[UIImage imageNamed:@"zan_comments"] forState:UIControlStateNormal];
        bt.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        bt.backgroundColor = YHrgbColorWithAlpha(0, 0, 0, 0.4);
        [bt setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [self.contentView addSubview:bt];
        self.zanButton = bt;
        [bt addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //5.职位
        YHIndentLabel *jobTitleLabel = [[YHIndentLabel alloc] init];
        jobTitleLabel.backgroundColor = YHrgbColorWithAlpha(0, 0, 0, 0.4);
        jobTitleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:jobTitleLabel];
        self.jobTitleLabel = jobTitleLabel;
        jobTitleLabel.font = [UIFont systemFontOfSize:YHJobTitleFont];
        
        //6.text正文
        YHIndentLabel *lbText = [[YHIndentLabel alloc] init];
        lbText.backgroundColor = YHrgbColorWithAlpha(0, 0, 0, 0.4);
        lbText.numberOfLines = 0;
        lbText.font = [UIFont systemFontOfSize:YHTextFont];
        lbText.textColor = [UIColor whiteColor];
        [self.contentView addSubview:lbText];
        self.text_label = lbText;
    }
    return self;
}

#pragma mark ------------------------------------------
#pragma mark external method
- (void)setComment:(YHCommentModel *)comment{
    _comment = comment;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:comment.userAvatar] placeholderImage:[UIImage imageNamed:@"head_img_04"]];
    self.nameLabel.text = comment.userName;
    [self.zanButton setTitle:[NSString stringWithFormat:@"%@", comment.pingPushed] forState:UIControlStateNormal];
    self.jobTitleLabel.text = comment.userJobTitle;
    self.text_label.text = comment.pingLun;
    
    self.bgImgView.frame = comment.bgImgViewFrame;
    self.iconImgView.frame = comment.iconFrame;
    self.nameLabel.frame = comment.nameFrame;
    self.accusBtn.frame = comment.accusFrame;
    self.zanButton.frame = comment.zanBtnFrame;
    self.jobTitleLabel.frame = comment.jobTitleFrame;
    self.text_label.frame = comment.textFrame;
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

#pragma mark ------------------------------------------
#pragma mark events
- (void)zanClicked:(UIButton *)zanBtn{
    YHZanCommentParam *param = [[YHZanCommentParam alloc] init];
    param.did = self.comment.pingUid;
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.token = [GlobeSingle shareGlobeSingle].uuid;
    param.pingId = self.comment.pingId;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlDingComment params:paramDic success:^(id  _Nonnull responseObj) {
        YHZanCommentResult *result = [YHZanCommentResult mj_objectWithKeyValues:responseObj];
        if (!result.pingPushed.integerValue) {
//            YHPopNoZanView *zv = [YHPopNoZanView popNoZanView];
//            [zv show];
            [SVProgressHUD showErrorWithStatus:result.message];
            return ;
        }
        if (result.status.integerValue == 1) {
            self.comment.pingPushed = result.pingPushed;
            [self.zanButton setTitle:[NSString stringWithFormat:@"%@", self.comment.pingPushed] forState:UIControlStateNormal];
            
            //通知代理
            if ([self.delegate respondsToSelector:@selector(commentCellDidDingComment:totalDings:)]) {
                [self.delegate commentCellDidDingComment:self totalDings:result.pingPushed];
            }
        }else{
            [MBProgressHUD showError:result.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

- (void)accuseClicked:(YHAccusationBtn *)accusBtn{
    YHAccuationParam *param = [[YHAccuationParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.pid = self.comment.pingId;
    accusBtn.accusDelegate.paramOfAccusation = param;
    [accusBtn.accusDelegate accuseWithVc:self.cmtVc];
}

@end
