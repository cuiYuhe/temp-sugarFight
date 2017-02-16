//
//  YHTestBaseUrlView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/7/25.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHTestBaseUrlView.h"
#import "YHPopAlertView.h"

@interface YHTestBaseUrlView()
@property (weak, nonatomic) IBOutlet UITextView *ossTextView;
@property (weak, nonatomic) IBOutlet UITextView *defineTextView;

@end

@implementation YHTestBaseUrlView

+ (YHTestBaseUrlView *)testBaseUrlView{
    YHTestBaseUrlView *testView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    testView.hidden = YES;
    return testView;
}



//tag,10,11
- (IBAction)OKAction:(UIButton *)sender {
    
    NSString *strUrl = nil;
    NSString *ali = nil;
    if (sender.tag == 10) {
        strUrl = self.ossTextView.text;
        ali = @"_阿里";
    }else if (sender.tag == 11) {
        strUrl = self.defineTextView.text;
    }
    
    [YHHttpTool shareHttpTool].testBaseUrl = strUrl;
    
    YHPopAlertView *pav = [YHPopAlertView popAlertViewSingleBtnWithContent:[NSString stringWithFormat:@"使用后台地址为%@:\n%@", ali, strUrl] cfm:nil];
    [pav show];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *finger = touches.anyObject;
    CGPoint curPoint = [finger locationInView:finger.view];
    CGPoint lastPoint = [finger previousLocationInView:finger.view];
    
    CGFloat changeX = curPoint.x - lastPoint.x;
    CGFloat changeY = curPoint.y - lastPoint.y;
    self.transform = CGAffineTransformTranslate(self.transform, changeX, changeY);
}

@end
