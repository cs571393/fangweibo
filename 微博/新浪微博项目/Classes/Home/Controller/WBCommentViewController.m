//
//  WBCommentViewController.m
//  新浪微博项目
//
//  Created by neng on 15/11/14.
//  Copyright (c) 2015年 neng. All rights reserved.
//

#import "WBCommentViewController.h"
#import "WBCommentTool.h"
#import "MBProgressHUD+MJ.h"

@interface WBCommentViewController ()

@end

@implementation WBCommentViewController

- (void)viewDidLoad {
    
    self.navTitle = @"评论";
    self.placeholoder = @"写评论...";
    
    [super viewDidLoad];
    
}


- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendTitle
{
    [WBCommentTool commentWithText:self.textView.text idStr:self.idStr success:^{
        
        [MBProgressHUD showSuccess:@"评论成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"评论失败"];
    }];
}


@end
