//
//  WBRetweetViewController.m
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBRetweetViewController.h"
#import "WBRetweetLabel.h"
#import "WBRetweetTool.h"
#import "WBStatus.h"
#import "MBProgressHUD+MJ.h"

@interface WBRetweetViewController ()

@property (nonatomic,weak) WBRetweetLabel *rLabel;

@end

@implementation WBRetweetViewController

- (void)viewDidLoad {
    
    self.navTitle = @"转发微博";
    self.placeholoder = @"说说分享心得...";
    
    [super viewDidLoad];
    
    
    //创建转发的label
    WBRetweetLabel *rLabel = [[WBRetweetLabel alloc] init];
    [self.textView addSubview:rLabel];
    rLabel.frame = CGRectMake(0, 70, self.view.bounds.size.width, 70);
    rLabel.status = self.status;
    self.rLabel = rLabel;
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendTitle
{
    [WBRetweetTool retweetWithText:self.textView.text idStr:self.status.idstr success:^{
        
        [MBProgressHUD showSuccess:@"转发成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"转发失败"];
    }];
}

@end
