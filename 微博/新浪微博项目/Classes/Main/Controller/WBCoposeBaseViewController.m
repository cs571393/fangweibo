//
//  WBCoposeBaseViewController.m
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBCoposeBaseViewController.h"

#import "WBComposeTabBar.h"
#import "WBComposePhotosView.h"
#import "WBComposeTool.h"
#import "MBProgressHUD+MJ.h"

#import "AFNetworking.h"
#import "WBComposeParam.h"
#import "MJExtension.h"

@interface WBCoposeBaseViewController () <UITextViewDelegate,WBComposeTabBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


///工具栏
@property (nonatomic,weak) WBComposeTabBar *toolBar;
///照片视图
@property (nonatomic,weak) WBComposePhotosView *photosView;

///发送按钮
@property (nonatomic,strong) UIBarButtonItem *rightItem;

///选择的图片
@property (nonatomic,strong) NSMutableArray *images;

@end

@implementation WBCoposeBaseViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNavigation];
    
    //设置文本视图
    [self setUpTextView];
    
    //设置工具栏
    [self setUpToolBar];
    
    //添加相册视图
    [self setUpPhotosView];
}

#pragma mark - 设置相册视图
- (void)setUpPhotosView
{
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    
    //照片可以滚动，所以是添加到文本视图中
    [_textView addSubview:photosView];
    _photosView = photosView;
}

#pragma mark - 照片选择控制器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获得选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photosView.image = image;
    
    //退出照片选择控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
}

#pragma mark - 设置工具栏
- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    WBComposeTabBar *toolBar = [[WBComposeTabBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    //监听键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    toolBar.delegate = self;
}

//键盘弹出调用
- (void)keyboardShow:(NSNotification *)noti
{
    //获取键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //取出动画时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (frame.origin.y == self.view.height) { //键盘没有弹出
        
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
        
    }else{ //键盘弹出
        
        
        [UIView animateWithDuration:duration animations:^{
            //-frame.size.height 就是键盘目前的y值
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            
        }];
        
    }
}

#pragma mark - 工具栏代理方法
- (void)composeTabBar:(WBComposeTabBar *)composeTabBar didClickBtnWithTag:(NSInteger)tag
{
    if (tag == 0) {
        
        //模态推出图片选择控制器
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        //设置图片源
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - 设置TextView
//设置文本视图
- (void)setUpTextView
{
    WBTextView *textView = [[WBTextView alloc] initWithFrame:self.view.bounds];
    textView.placeholder = self.placeholoder;
    [self.view addSubview:textView];
    _textView = textView;
    
    //如果不能拖拽。就设置这个属性
    //    _textView.alwaysBounceVertical = YES;
    
    //监听文本改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    textView.delegate = self;
}

#pragma mark 处理键盘弹出与收回
- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{
    [_textView endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //弹出键盘
    [_textView becomeFirstResponder];
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//文本改变调用
- (void)textChange
{
    //根据有没有文本来隐藏占位文字
    if (_textView.text.length) {
        
        _textView.hidePlaceholder = YES;
        _rightItem.enabled = YES;
    }else{
        
        _textView.hidePlaceholder = NO;
        _rightItem.enabled = NO;
    }
    
}

#pragma mark - 导航条内容
//设置导航栏的东西
- (void)setUpNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = self.navTitle;
    
    //左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    //右边
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    item.enabled = NO;
    self.navigationItem.rightBarButtonItem = item;
    _rightItem = item;
}

//发送微博
- (void)compose
{
    //判断有没有图片
    if (self.images.count) {
        
        [self sendPicture];
        
    }else{
        
        //发送文字
        [self sendTitle];
    }
    
    
    
}

//发送图片并发送文本
- (void)sendPicture
{
    NSString *status = _textView.text.length ? _textView.text : @"分享图片";
    
    [WBComposeTool composeWithStatus:status image:self.images[0] success:^{
        
        _rightItem.enabled = NO;
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        
        _rightItem.enabled = YES;
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}

//发送文字
- (void)sendTitle
{
    //发送微博文本
    [WBComposeTool composeWithStatus:_textView.text success:^{
        
        [MBProgressHUD showSuccess:@"发送成功"];
        //回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"发送失败"];
    }];
}

//退出控制器
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
