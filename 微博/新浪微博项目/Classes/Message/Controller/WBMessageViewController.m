//
//  WBMessageViewController.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBMessageViewController.h"

@interface WBMessageViewController ()

@end

@implementation WBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //聊天按钮
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"聊天" style:UIBarButtonItemStyleBordered target:self action:@selector(chat)];
    self.navigationItem.rightBarButtonItem = chat;
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//聊天
- (void)chat
{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"messageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //设置附属物
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_at"];
            cell.textLabel.text = @"@我的";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_comments"];
            cell.textLabel.text = @"评论";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_good"];
            cell.textLabel.text = @"赞";
            break; 
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_subscription"];
            cell.textLabel.text = @"订阅消息";
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_callup"];
            cell.textLabel.text = @"电话";
            break;
        case 5:
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_messagebox"];
            cell.textLabel.text = @"消息盒子";
            break;
            
        default:
            

            break;
    }
    
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


@end
