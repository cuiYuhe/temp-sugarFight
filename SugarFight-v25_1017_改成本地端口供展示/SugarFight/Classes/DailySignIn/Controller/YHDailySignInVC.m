//
//  YHDailySignInVC.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/22.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHDailySignInVC.h"
#import "YHCalendarView.h"
#import "YHDateTool.h"
#import "YHGetSignInfoParam.h"
#import "YHGetSignInfoResult.h"
#import "YHSignResult.h"

static NSString *const strUrlGetSignInfo = @"jianpai/Score/getPSignScore";
static NSString *const strUrlSign = @"jianpai/Score/sign";

@interface YHDailySignInVC ()
@property (weak, nonatomic) IBOutlet YHCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UILabel *monthMathLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthEngLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) UIImageView *scoreImgV;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
/** 日期 */
@property (nonatomic, strong) NSDate *date;
/** 英文的月份 */
@property (nonatomic, strong) NSArray *engMonths;
/** YHGetSignInfoResult model */
@property (nonatomic, strong) YHGetSignInfoResult *signInfoResult;
/** YHSignResult model */
@property (nonatomic, strong) YHSignResult *signResultM;
/** 参数:1.获取签到天数分数信息的请求,2.点击签到时的请求.因为相同,所以共用 */
@property (nonatomic, strong) NSDictionary *signParam;

@end

@implementation YHDailySignInVC
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSArray *)engMonths{
    if (!_engMonths) {
        _engMonths = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    }
    return _engMonths;
}

- (UIImageView *)scoreImgV{
    if (!_scoreImgV) {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.image = [UIImage imageNamed:@"score+0.5"];
        CGFloat ivW = 30;
        CGFloat ivH = 30;
        CGFloat margin = 30;
        CGRect signInBtnF = [self.signInBtn.superview convertRect:self.signInBtn.frame toView:nil];
        
        CGFloat ivX = CGRectGetMaxX(signInBtnF) - ivW - margin;
        CGFloat ivY = signInBtnF.origin.y;
        iv.frame = CGRectMake(ivX, ivY, ivW, ivH);
        iv.alpha = 0;
        [self.view addSubview:iv];
        _scoreImgV = iv;
    }
    return _scoreImgV;
}

- (NSDictionary *)signParam{
    if (!_signParam) {
        YHGetSignInfoParam *param = [[YHGetSignInfoParam alloc] init];
        param.uid = [GlobeSingle shareGlobeSingle].userID;
        param.uuid = [GlobeSingle shareGlobeSingle].uuid;
        NSDictionary *paramDic = [param mj_keyValues];
        _signParam = paramDic;
    }
    return _signParam;
}

- (NSDate *)date{
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

#pragma mark ------------------------------------------
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    
    //得到当月签到天数,分数等信息
    [self getSignInfo];
}

- (void)setup{
    NSInteger month = [[YHDateTool shareDateTool] getMonth:self.date];
    self.monthMathLabel.text = [NSString stringWithFormat:@"%zd", month];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM";
    NSString *m = self.engMonths[month - 1];
    self.monthEngLabel.text = m;
    
    self.calendarView.date = self.date;
}

//得到当月签到天数等信息
- (void)getSignInfo{
    
    [YHHttpTool postNotByJSONDataWithUrl:strUrlGetSignInfo params:self.signParam success:^(id  _Nonnull responseObj) {
        
        self.signInfoResult = [YHGetSignInfoResult mj_objectWithKeyValues:responseObj];
        self.calendarView.signInDays = [[NSMutableArray alloc]initWithArray:self.signInfoResult.signTimes];
        self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", self.signInfoResult.score.floatValue];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark events
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signInAction:(id)sender {
    YHFunc
    
    //通知服务器
    [YHHttpTool postNotByJSONDataWithUrl:strUrlSign params:self.signParam success:^(id  _Nonnull responseObj) {
        self.signResultM = [YHSignResult mj_objectWithKeyValues:responseObj];
        if (self.signResultM.stuatus.integerValue == 1) {//请求成功
            //1.弹出scoreImgV并消失
            self.scoreImgV.alpha = 1;
            [UIView animateWithDuration:1 animations:^{
                self.scoreImgV.yh_y -= 40;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:2 animations:^{//时间好像没效果
                    self.scoreImgV.alpha = 0;
                    [self.scoreImgV removeFromSuperview];
                }];
            }];
            
            //2.更新分数及签到天数
            [self getSignInfo];
        }else{
            [MBProgressHUD showError:self.signResultM.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后重试."];
        YHLog(@"error = %@", error);
    }];
    
    
}

@end
