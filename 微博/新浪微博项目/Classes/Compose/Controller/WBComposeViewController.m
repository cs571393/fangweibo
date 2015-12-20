//
//  WBComposeViewController.m
//  新浪微博项目
//
//  Created by neng on 15/10/5.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBComposeViewController.h"

@interface WBComposeViewController ()

@end

@implementation WBComposeViewController

- (void)viewDidLoad
{
    self.navTitle = @"发微博";
    self.placeholoder = @"分享新鲜事";
    
    [super viewDidLoad];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
