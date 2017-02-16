//
//  YHCalendarView.m
//  testCalendarOfSugarFight
//
//  Created by Cui yuhe on 16/5/21.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHCalendarView.h"
#import "YHDateTool.h"

static CGFloat const YHWeekSize = 10.0f;

@interface YHCalendarCell : UICollectionViewCell
@property (nonatomic , strong) UILabel *dateLabel;
@end

@implementation YHCalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [_dateLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self.contentView addSubview:_dateLabel];
    }
    return self;
}

+ (NSString *)identifier{
    return NSStringFromClass(self);
}

@end

@interface YHCalendarFlowLayout : UICollectionViewFlowLayout

@end

@implementation YHCalendarFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    // 1.设置布局对象属性
    CGFloat itemH = self.collectionView.bounds.size.height / 7; //目前是55
    CGFloat itemW = self.collectionView.bounds.size.width / 7;
    self.itemSize = CGSizeMake(itemW, itemH);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 2.设置collectionView对象属性
    //    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end

@interface YHCalendarCollectionView : UICollectionView

@end

@implementation YHCalendarCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    YHCalendarFlowLayout *myLayout = [[YHCalendarFlowLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:myLayout]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        [self registerClass:[YHCalendarCell class] forCellWithReuseIdentifier:[YHCalendarCell identifier]];
    }
    return self;
}

@end


@interface YHCalendarView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic , strong) NSArray *weekDayArray;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSCalendar *calendar;
/** 开始显示日期的cell,为第几个cell */
@property (nonatomic, assign) NSInteger firstWeekday;
/** 目标修改的签到的cell的索引 */
@property (nonatomic, strong) NSMutableArray *targetSignInCellIndexs;

@end

@implementation YHCalendarView
#pragma mark ------------------------------------------
#pragma mark lazy
- (NSMutableArray *)targetSignInCellIndexs{
    if (!_targetSignInCellIndexs) {
        _targetSignInCellIndexs = [[NSMutableArray alloc] init];
    }
    return _targetSignInCellIndexs;
}

- (NSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (NSInteger)firstWeekday{
    if (!_firstWeekday) {
        _firstWeekday = [[YHDateTool shareDateTool] firstWeekdayInMonth:self.date];
    }
    return _firstWeekday;
}

- (NSDate *)date{
    if (!_date) {
        return [NSDate date];
    }else{
        return _date;
    }
}

- (NSMutableArray *)signInDays{
    if (!_signInDays) {
        _signInDays = [[NSMutableArray alloc] init];
    }
    return _signInDays;
}

#pragma mark ------------------------------------------
#pragma mark life cycle
- (void)awakeFromNib{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    
}

#pragma mark ------------------------------------------
#pragma mark internal methods
- (void)setup{
    
    YHCalendarCollectionView *clv = [[YHCalendarCollectionView alloc] init];
    self.collectionView = clv;
    [self addSubview:clv];
    clv.dataSource = self;
    clv.delegate = self;
    _weekDayArray = @[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
}


#pragma mark ------------------------------------------
#pragma mark external methods
- (void)setSignInDays:(NSMutableArray *)signInDays{
    _signInDays = signInDays;
    for (NSNumber *num in signInDays) {
        NSNumber *modifiedNum = @(num.integerValue + self.firstWeekday - 1);
        [self.targetSignInCellIndexs addObject:modifiedNum];
    }
    
    [self.collectionView reloadData];
}

#pragma -mark collectionView data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YHCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHCalendarCell identifier] forIndexPath:indexPath];
    
    //section0为:日一二三...
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        cell.dateLabel.font = [UIFont boldSystemFontOfSize:YHWeekSize];
    } else { //section == 1
        
        //1.设置签到日期的背景
        //发现点击签到后,section1的背景色发生了变化.暂时如此处理,待仔细检查
        cell.dateLabel.backgroundColor = [UIColor clearColor];
        NSNumber *rowNum = @(indexPath.row);
        if ([self.targetSignInCellIndexs containsObject:rowNum]) {
            cell.dateLabel.backgroundColor = YHrgbColor(185, 138, 110);
        }/*else{
            cell.dateLabel.backgroundColor = [UIColor clearColor];
        }*/
        
        cell.dateLabel.font = [UIFont italicSystemFontOfSize:14];
        NSInteger daysInThisMonth = [[YHDateTool shareDateTool] totalDaysInMonth:self.date];
        
        /** 开始显示日期的cell */
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < self.firstWeekday) {//月初:1号之前的空白cell
            [cell.dateLabel setText:@""];
            
        }else if (i > self.firstWeekday + daysInThisMonth - 1){//月末:30/31/29号之后的空白cell
            [cell.dateLabel setText:@""];
            
        }else{//月初到月末的cell的格式设置
            day = i - self.firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%zd",day]];
            
            //this month
            
        }
    }
    return cell;
}

@end
