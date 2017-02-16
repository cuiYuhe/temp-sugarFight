//
//  YHPopAllScreenImageView.m
//  SugarFight
//
//  Created by Cui yuhe on 16/6/14.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHPopAllScreenImageView.h"


@interface YHPopAllScreenImageView()<UIScrollViewDelegate>

/** 占据全屏的imageView */
@property (nonatomic, weak) UIImageView *screenImageView;
/** 最外层的scrollView,以放大缩小 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** cover,点击cover时,移走当前所有控件 */
@property (nonatomic, weak) UIView *cover;

@end

@implementation YHPopAllScreenImageView

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
    
}

- (void)setup{
    [super setup];
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    
}

#pragma mark ------------------------------------------
#pragma mark lazy
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        //1.最外层的scrollView,以放大缩小
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView = scrollView;
        //添加到window
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        scrollView.frame = window.bounds;
        scrollView.maximumZoomScale = 3.0;
        scrollView.minimumZoomScale = 1;
        [window addSubview:scrollView];
    }
    return _scrollView;
}

- (UIImageView *)screenImageView{
    if (!_screenImageView) {
        
        //2.添加cover
        UIView *cover = [[UIView alloc] initWithFrame:self.scrollView.bounds];
        UITapGestureRecognizer *tapCover = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreenImgView:)];
        cover.backgroundColor = [UIColor clearColor];
        cover.userInteractionEnabled = YES;
        [cover addGestureRecognizer:tapCover];
        self.cover = cover;
        [self.scrollView addSubview:cover];
        
        //3.imageView:放大的图片
        UIImageView *iv = [[UIImageView alloc] init];
        iv.userInteractionEnabled = YES;
        iv.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tapIv = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreenImgView:)];
        [iv addGestureRecognizer:tapIv];
        _screenImageView = iv;
        [self.scrollView addSubview:iv];
        
        //3.设置frame并实现坐标动画
        CGRect rect = [self.superview convertRect:self.frame toView:nil];
        iv.frame = rect;
        
        //设置图片
        iv.image = self.image;
    }
    return _screenImageView;
}

+ (YHPopAllScreenImageView *)popAllScreenImageView{
    YHPopAllScreenImageView *iv = [[self alloc] init];
    return iv;
}



#pragma mark ------------------------------------------
#pragma mark events
- (void)tap:(UITapGestureRecognizer *)tapGes{
    //如果当前imgView没有图片,则没有必要弹出全屏imgView
    if (!self.image) return;
    
    
    //加载全屏的imgView
    __block CGRect rect = self.screenImageView.frame;
    [UIView animateWithDuration:0.8 animations:^{
        rect.size.width = self.scrollView.yh_width; // 占据整个屏幕;
        rect.size.height = rect.size.width * (self.image.size.height / self.image.size.width);
        rect.origin.x = 0;
        rect.origin.y = (self.scrollView.yh_height - rect.size.height) * 0.5;
        self.screenImageView.frame = rect;
    }];
    
    //设置contentSize,因为上部留有额外空间,要加上.不然滚不到最下面
    self.scrollView.contentSize = self.image.size;
//    YHLog(@"edge = %@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    
}

//全屏imgView的tap事件
- (void)tapScreenImgView:(UITapGestureRecognizer *)tapGes{
    
    [UIView animateWithDuration:0.5 animations:^{//先透明,再消失
        self.scrollView.alpha = 0.3;
        
    }completion:^(BOOL finished) {
        [self.screenImageView removeFromSuperview];
        [self.scrollView removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
}

#pragma mark ------------------------------------------
#pragma mark UIScrollView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.screenImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    
    if (scale > 1.5) {
        
        CGRect rect = self.screenImageView.frame;
        CGFloat y = (self.scrollView.yh_height - rect.size.height / scale) * 0.5;
        
        scrollView.contentInset = UIEdgeInsetsMake(-y, 0, y, 0);
    }else{
        scrollView.contentInset = UIEdgeInsetsZero;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    self.screenImageView.center = self.center;
}

@end
