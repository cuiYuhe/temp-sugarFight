//
//  YHStudyInsideExerciseVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHStudyInsideExerciseVc.h"
#import "YHStudyInsideExerciseCell.h"
#import "YHPopExerciseScoreView.h"
#import "YHCourseQuesParam.h"
#import "YHCourseQuesResult.h"
#import "YHSubmitQuesParam.h"
#import "YHSubmitQuesResult.h"
#import "YHPopAlertView.h"

static NSString *YHStrUrlGetCourseQuestions = @"jianpai/Study/getCourseQuestions";
static NSString *YHStrUrlSubmitQuestions = @"jianpai/Study/commitQuestions";

@interface YHStudyInsideExerciseVc ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** YHCourseQuesResult */
@property (nonatomic, strong) YHCourseQuesResult *courseQuesResult;

@end

@implementation YHStudyInsideExerciseVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self loadQuestions];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //记录tableView宽度,以计算cell的高度
    [GlobeSingle shareGlobeSingle].tableViewWidthOfExercise = self.tableView.yh_width;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark ------------------------------------------
#pragma mark initialise
- (void)setup{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHStudyInsideExerciseCell class]) bundle:nil] forCellReuseIdentifier:[YHStudyInsideExerciseCell identifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];

}

#pragma mark ------------------------------------------
#pragma mark internal method
- (void)setupAfterGetQuestions{
    
    if (self.courseQuesResult.isPracticeMode) {
        YHPopAlertView *popAlertView = [YHPopAlertView popAlertViewSingleBtnWithContent:self.courseQuesResult.practiceModeMsg cfm:nil];
        [popAlertView show];
    }
    [self.tableView reloadData];
}

#pragma mark ------------------------------------------
#pragma mark network method
- (void)loadQuestions{
    YHCourseQuesParam *param = [[YHCourseQuesParam alloc] init];
    param.courseId = @(self.courseId);
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    NSDictionary *paramDic = [param mj_keyValues];
    [SVProgressHUD showWithStatus:nil];
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetCourseQuestions params:paramDic success:^(id  _Nonnull responseObj) {
        self.courseQuesResult = [YHCourseQuesResult mj_objectWithKeyValues:responseObj];
        if (self.courseQuesResult.status.integerValue == 1) {
            [self setupAfterGetQuestions];
        }else{
            [MBProgressHUD showError:self.courseQuesResult.message];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

/**
 *  提交答案-内部调用方法
 *  @param totalScore 总分数
 */
- (void)submitAnswersToServerWithTotalScore:(CGFloat)totalScore param:(NSMutableArray*)params submitBtn:(UIButton *)submitBtn{
    YHSubmitQuesParam *param = [[YHSubmitQuesParam alloc] init];
    param.uid = [GlobeSingle shareGlobeSingle].userID;
    param.uuid = [GlobeSingle shareGlobeSingle].uuid;
    param.courseId = self.courseId;
    param.totalScore = totalScore;
    
    param.answers = params;
    NSDictionary *paramDic = [param mj_keyValues];
    [YHHttpTool postByJSONDataWithUrl:YHStrUrlSubmitQuestions params:paramDic success:^(id  _Nonnull responseObj) {
        YHFunc
        YHSubmitQuesResult *submitRes = [YHSubmitQuesResult mj_objectWithKeyValues:responseObj];
        
        if (submitRes.status.integerValue == 1) {
            //提交按钮不可点击
            submitBtn.enabled = NO;
            //4. 弹出分数
            YHPopExerciseScoreView *exerciseScoreView = [YHPopExerciseScoreView popExerciseScoreView];
            
            //虽然这个分数就是上面方法中的totalScore,但是后台以后有可能会重新计算这个分数,所以使用后台的值
            exerciseScoreView.score = submitRes.myScore;
            [exerciseScoreView show];
        }else{
            [MBProgressHUD showError:submitRes.message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"获取分数失败,请检查网络并稍后重试."];
        YHLog(@"error = %@", error);
    }];
    
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submitAction:(UIButton *)sender {
    
    //1.是否所有题目都已选择答案
    CGFloat totalScore = 0;
    
    for (YHCourseQuesAnswerModel *quesM in self.courseQuesResult.courseQuestions) {
        if (!quesM.isPickedAnswer) {
            [MBProgressHUD showError:@"请做完所有题目再提交."];
            return;
        }
    }
    //2.发提交分数通知.通知中给个容器让接收的cell给东西
    //用来传递参数.
    NSMutableArray *answerPramas = [NSMutableArray array];
    NSDictionary *userInfo = @{YHCommitExerciseAnswerNotificationKey : answerPramas};
    [[NSNotificationCenter defaultCenter] postNotificationName:YHCommitExerciseAnswerNotification object:nil userInfo:userInfo];
    //3.总分数
    for (YHCourseQuesAnswerModel *quesM in self.courseQuesResult.courseQuestions) {
        totalScore += quesM.pickAnswerScore;
    }

    //3.发送到server
    [self submitAnswersToServerWithTotalScore:totalScore param:(NSMutableArray *)answerPramas submitBtn:sender];
    
}

#pragma mark ------------------------------------------
#pragma mark UITableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.courseQuesResult.courseQuestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHStudyInsideExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHStudyInsideExerciseCell identifier] forIndexPath:indexPath];
    cell.questionM = self.courseQuesResult.courseQuestions[indexPath.row];
    return cell;
}

#pragma mark ------------------------------------------
#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHCourseQuesAnswerModel *answerM = self.courseQuesResult.courseQuestions[indexPath.row];
    return answerM.cellHeight;
}

@end
