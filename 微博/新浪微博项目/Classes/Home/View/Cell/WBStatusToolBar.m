//
//  WBStatusToolBar.m
//  新浪微博项目
//
//  Created by neng on 15/10/4.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"

@interface WBStatusToolBar ()

///转发按钮
@property (nonatomic,weak) UIButton *retweetBtn;
///评论按钮
@property (nonatomic,weak) UIButton *commentBtn;
///赞按钮
@property (nonatomic,weak) UIButton *unlikeBtn;

///所有的按钮
@property (nonatomic,strong) NSMutableArray *btns;
///分割线
@property (nonatomic,strong) NSMutableArray *divides;


@end

@implementation WBStatusToolBar

- (NSMutableArray *)divides
{
    if (_divides == nil) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

-(NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildView];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
    }
    return self;
}

//创建子控件
- (void)setUpAllChildView
{
    //转发
    UIButton *retweetBtn = [self setUpOneBtnWithTitle:@"转发" imageName:@"timeline_icon_retweet"];
    retweetBtn.tag = 0;
    _retweetBtn = retweetBtn;
    
    //评论
    UIButton *commentBtn = [self setUpOneBtnWithTitle:@"评论" imageName:@"timeline_icon_comment"];
    commentBtn.tag = 1;
    _commentBtn = commentBtn;
    
    //赞
    UIButton *unlikeBtn = [self setUpOneBtnWithTitle:@"赞" imageName:@"timeline_icon_unlike"];
    unlikeBtn.tag = 2;
    _unlikeBtn = unlikeBtn;
    
    //两条分割线
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        
        [self addSubview:divideV];
        [self.divides addObject:divideV];
    }
    
}

//设置一个按钮
- (UIButton *)setUpOneBtnWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    //监听事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
#pragma mark - 监听的事件
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(statusToolBar:didClickedBtnWithTag:idStr:)]) {
        [self.delegate statusToolBar:self didClickedBtnWithTag:btn.tag idStr:self.status.idstr];
    }
}

//布局控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSInteger count = self.btns.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = WBScreenW / count;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    
    }
    
    //设置分割线的frame
    int i = 1;
    for (UIImageView *imageView in self.divides) {
        UIButton *btn = self.btns[i];
        //
        imageView.x = btn.x;
        i++;
    }
}


- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    //设置转发数
    [self setBtn:_retweetBtn Count:status.reposts_count];
    
    //设置评论数
    [self setBtn:_commentBtn Count:status.comments_count];
    
    //设置赞数
    [self setBtn:_unlikeBtn Count:status.attitudes_count];
}

//设置按钮上显示的数值
- (void)setBtn:(UIButton *)btn Count:(int)count
{
    //
    NSString *title = nil;
    if(count){
        
        //如果转发数大于10000
        if (count > 10000) {
            
            CGFloat floatVlaue = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatVlaue];
            
            //如果不超过1W1 就只需要显示1W 而不需要显示1.0W
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        //解决转发数、评论数、赞数的循环引用问题
        switch (btn.tag) {
            case 0:
                [btn setTitle:@"转发" forState:UIControlStateNormal];
                break;
            case 1:
                [btn setTitle:@"评论" forState:UIControlStateNormal];
                break;
            case 2:
                [btn setTitle:@"赞" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    
}


@end
