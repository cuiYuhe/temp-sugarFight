//
//  YHStudyVc.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/3.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHStudyListVc.h"
#import "YHStudyListCell.h"
#import "YHStudyInsidePPTVc.h"
#import "YHCoursesResult.h"

static NSString *const YHStrUrlGetCourse = @"jianpai/Study/getCourses";

@interface YHStudyListVc ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** YHCoursesResult */
@property (nonatomic, strong) YHCoursesResult *coursesResult;

@end

@implementation YHStudyListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHStudyListCell class]) bundle:nil] forCellReuseIdentifier:[YHStudyListCell identifier]];
    self.tableView.rowHeight = 70;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //做完题回来时要刷新分数
    [self loadCourses];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

///得到课程后的操作
- (void)setupAfterLoadingCourses{
    [self.tableView reloadData];
}

#pragma mark ------------------------------------------
#pragma mark network method
- (void)loadCourses{
    
    [SVProgressHUD showWithStatus:nil];
    NSDictionary *paramDic = @{
                               @"uid" : [GlobeSingle shareGlobeSingle].userID,
                               @"uuid" : [GlobeSingle shareGlobeSingle].uuid,
                               };
    [YHHttpTool postNotByJSONDataWithUrl:YHStrUrlGetCourse params:paramDic success:^(id  _Nonnull responseObj) {
        
        [SVProgressHUD dismiss];
        self.coursesResult = [YHCoursesResult mj_objectWithKeyValues:responseObj];
        if (self.coursesResult.status.integerValue == 1) {
            [self setupAfterLoadingCourses];
        }else{
            [MBProgressHUD showError:self.coursesResult.message];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:@"请检查网络,稍后重试."];
        YHLog(@"error = %@", error);
    }];
}

#pragma mark ------------------------------------------
#pragma mark event
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------------------------
#pragma mark UITableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coursesResult.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHStudyListCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHStudyListCell identifier] forIndexPath:indexPath];
    cell.course = self.coursesResult.courses[indexPath.row];
    return cell;
}

#pragma mark ------------------------------------------
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHStudyInsidePPTVc *studyInsideVc = [[GlobeSingle shareGlobeSingle] vcWithSbName:NSStringFromClass([YHStudyInsidePPTVc class])];
    
    YHCourseModel *course = self.coursesResult.courses[indexPath.row];
    studyInsideVc.courseId = course.courseId;
    [UIViewController yh_ModalVcWithSourceVc:self destinVc:studyInsideVc presentAnimated:YES dismissAnimated:YES presentBlock:nil dismissBlock:nil];
}


@end
