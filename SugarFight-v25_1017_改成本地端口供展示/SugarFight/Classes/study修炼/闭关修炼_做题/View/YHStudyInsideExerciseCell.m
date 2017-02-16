//
//  YHStudyInsideExerciseCell.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/4.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHStudyInsideExerciseCell.h"
#import "YHCourseQuesAnswerModel.h"
#import "YHSubmitQuesSubAnswerParam.h"

/** 答案按钮的最小的tag */
static NSInteger const YHAnswerBtnMinTag = 10;

@interface YHStudyInsideExerciseCell()

/** 题目序号 */
@property (weak, nonatomic) IBOutlet UIButton *questionNoBtn;
/** 题目描述 */
@property (weak, nonatomic) IBOutlet UILabel *questionDesLabel;
/** 答案A */
@property (weak, nonatomic) IBOutlet UILabel *choiceALabel;
@property (weak, nonatomic) IBOutlet UILabel *choiceBLabel;
@property (weak, nonatomic) IBOutlet UILabel *choiceCLabel;
@property (weak, nonatomic) IBOutlet UILabel *choiceDLabel;
/** 正确答案label */
@property (weak, nonatomic) IBOutlet UILabel *rightAnswerLabel;
/** 正确或错误标志 */
@property (weak, nonatomic) IBOutlet UIImageView *trueOrFalseImageView;

@property (weak, nonatomic) IBOutlet UIButton *answerABtn;
@property (weak, nonatomic) IBOutlet UIButton *answerBBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerCBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerDBtn;

/** A,B,C,D */
@property (nonatomic, strong) NSArray *rightAnswers;
/** 所有的4个: answerBtn */
@property (nonatomic, strong) NSArray *answerBtns;
/** 选项A 包装view */
@property (weak, nonatomic) IBOutlet UIView *answerAView;
/** 选项B 包装view */
@property (weak, nonatomic) IBOutlet UIView *answerBView;
/** 选项C 包装view */
@property (weak, nonatomic) IBOutlet UIView *answerCView;
/** 选项D 包装view */
@property (weak, nonatomic) IBOutlet UIView *answerDView;

@end

@implementation YHStudyInsideExerciseCell
- (NSArray *)rightAnswers{
    if (!_rightAnswers) {
        _rightAnswers = @[@"A", @"B", @"C", @"D"];
    }
    return _rightAnswers;
}

- (NSArray *)answerBtns{
    if (!_answerBtns) {
        self.answerBtns = @[_answerABtn, _answerBBtn, _answerCBtn, _answerDBtn];
    }
    return _answerBtns;
}

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
    self.contentView.backgroundColor = [UIColor clearColor];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(commitAnswerObserver:) name:YHCommitExerciseAnswerNotification object:nil];
    
    //1.绑定回答按钮的tag
    self.answerABtn.tag = YHAnswerBtnMinTag;
    self.answerBBtn.tag = YHAnswerBtnMinTag + 1;
    self.answerCBtn.tag = YHAnswerBtnMinTag + 2;
    self.answerDBtn.tag = YHAnswerBtnMinTag + 3;
    
    for (UIButton *btn in self.answerBtns) {
        [btn addTarget:self action:@selector(pickAnswerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

#pragma mark ------------------------------------------
#pragma mark internal method
///设置答案按钮的选中状态
- (void)setupAnswerBtnSelectedStateWithTag:(NSInteger)selectedTag{
    
    for (UIButton *btn in self.answerBtns) {
        if (btn.tag == selectedTag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}

- (void)setQuestionM:(YHCourseQuesAnswerModel *)questionM{
    _questionM = questionM;
    
    [self.questionNoBtn setNormalTitle:[NSString stringWithFormat:@"%zd", questionM.questionId]];
    self.questionDesLabel.text = questionM.questionDescription;
    
    //设置答案选项的展示
    void(^setChoiceLabel)(UIView *answerView, UILabel *label, NSString *answer) = ^(UIView *answerView, UILabel *label, NSString *answer){
        if (!answer || [answer isEqualToString:@""]) {
            answerView.hidden = YES;
        }else{
            answerView.hidden = NO;
            label.text = answer;
        }
    };
    setChoiceLabel(self.answerAView, self.choiceALabel, questionM.answerA);
    setChoiceLabel(self.answerBView, self.choiceBLabel, questionM.answerB);
    setChoiceLabel(self.answerCView, self.choiceCLabel, questionM.answerC);
    setChoiceLabel(self.answerDView, self.choiceDLabel, questionM.answerD);
    
    self.rightAnswerLabel.text = [NSString stringWithFormat:@"答案:\n%@", questionM.rightAnswer];
    
    if (self.questionM.pickAnswerTag > 0) {//已经被赋值,初始为-1,会越界.
                            
        if ([self.rightAnswers[self.questionM.pickAnswerTag - YHAnswerBtnMinTag] isEqualToString:self.questionM.rightAnswer]) {//回答正确
            self.trueOrFalseImageView.image = [UIImage imageNamed:@"true_exercise"];
        }else {//回答错误
            self.trueOrFalseImageView.image = [UIImage imageNamed:@"false_exercise"];
        }
    }
    
    //设置答案按钮的选中状态
    [self setupAnswerBtnSelectedStateWithTag:questionM.pickAnswerTag];
}

#pragma mark ------------------------------------------
#pragma mark event
- (void)pickAnswerClick:(UIButton *)btn{
    
    //标注已经做了此题
    self.questionM.pickedAnswer = YES;
    
    [self setupAnswerBtnSelectedStateWithTag:btn.tag];
    
    //防止循环引用
    self.questionM.pickAnswerTag = btn.tag;
    
    //得分
    NSInteger pickAnswerTag = self.questionM.pickAnswerTag;
    NSString *pickedAnswer = self.rightAnswers[pickAnswerTag - YHAnswerBtnMinTag];
    NSString *standardAnswer = self.questionM.rightAnswer;
    if ([pickedAnswer isEqualToString:standardAnswer]) {
        self.questionM.pickAnswerScore = self.questionM.questionScore;
        self.questionM.answerRight = YES;
    }else{
        self.questionM.pickAnswerScore = 0;
        self.questionM.answerRight = NO;
    }
}

#pragma mark ------------------------------------------
#pragma mark observer
- (void)commitAnswerObserver:(NSNotification *)noti{

    self.rightAnswerLabel.hidden = NO;
    self.trueOrFalseImageView.hidden = NO;
    
    if ([self.rightAnswers[self.questionM.pickAnswerTag - YHAnswerBtnMinTag] isEqualToString:self.questionM.rightAnswer]) {//回答正确
        self.questionM.answerRight = YES;
        self.trueOrFalseImageView.image = [UIImage imageNamed:@"true_exercise"];
        
    }else {//回答错误
        self.questionM.answerRight = NO;
        self.trueOrFalseImageView.image = [UIImage imageNamed:@"false_exercise"];
    }
    
    //2.设置vc请求所用的参数
    NSMutableArray *temp = [noti.userInfo objectForKey:YHCommitExerciseAnswerNotificationKey];
    YHSubmitQuesSubAnswerParam *param = [[YHSubmitQuesSubAnswerParam alloc] init];
    param.questionId = self.questionM.questionId;
    param.choiceAnswer = self.rightAnswers[self.questionM.pickAnswerTag - YHAnswerBtnMinTag];
    param.answerScore = self.questionM.questionScore;
    [temp addObject:param];

}

@end
