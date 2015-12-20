//
//  WBOAuthViewController.m
//  新浪微博项目
//
//  Created by neng on 15/10/2.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "WBRootCotrollerTool.h"

#define WBBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define WBClient_id @"697062942"
#define WBRedirect_uri @"http://www.baidu.com"
#define WBClient_secret @"971abc4b59c8a22d124b132866d0920e"


@interface WBOAuthViewController () <UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建一个UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //拼接url字符串
    NSString *baseUrl = WBBaseUrl;
    NSString *client_id = WBClient_id;
    NSString *redirect_uri = WBRedirect_uri;
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    //创建Url
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载请求
    [webView loadRequest:request];
}

#pragma mark - UIWebView代理方法
- (void)webViewDidStartLoad:(nonnull UIWebView *)webView
{
    //提示用户
    [MBProgressHUD showMessage:@"正在加载..."];
}
- (void)webViewDidFinishLoad:(nonnull UIWebView *)webView
{
    //移除动画
    [MBProgressHUD hideHUD];
}
- (void)webView:(nonnull UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [MBProgressHUD hideHUD];
}

//通过这个方法来拦截请求
- (BOOL)webView:(nonnull UIWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    //找到code的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    //截取字符串
    if (range.length != 0) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        //有可能后面还跟着参数.也把后面的截掉  保证只剩下code
        NSRange otherRange = [code rangeOfString:@"&"];
        if (otherRange.length != 0) {
            code = [code substringToIndex:otherRange.location];
        }
        
        //换取accessToken
        [self accessTokenWith:code];
        
        //不需要显示回调页
        return NO;
    }
    
    return YES;
}

///换取accessToken
- (void)accessTokenWith:(NSString *)code
{
    [WBAccountTool accountWithCode:code success:^{
        //成功授权
        //选择控制器
        [WBRootCotrollerTool chooseRootCotroller:WBKeyWindow];
        
    } failure:^{
        
        NSLog(@"...");
    }];
    
}

@end
