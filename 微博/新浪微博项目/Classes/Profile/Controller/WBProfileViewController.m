//
//  WBProfileViewController.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBProfileViewController.h"

@interface WBProfileViewController ()

@end

@implementation WBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //聊天按钮
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setUpSettings)];
    self.navigationItem.rightBarButtonItem = settings;
}

//设置
- (void)setUpSettings
{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numbre;
    if (section == 0) {
        numbre = 1;
    }
    else if (section == 1){
        numbre = 2;
    }
    else if (section ==2){
        numbre = 2;
    }
    else{
        numbre = 1;
    }
    
    return numbre;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *text = [[NSArray alloc]initWithObjects:@"新的好友",@"我的相册",@"我的赞",@"微博会员",@"微博支付",@"草稿箱", nil];
    NSArray *imageName = [[NSArray alloc]initWithObjects:@"new_friend",@"album",@"like",@"vip",@"pay",@"draft", nil];
    NSInteger number;
    if (indexPath.section == 0) {
        number = indexPath.row;
    }
    else if(indexPath.section == 1){
        number = indexPath.row + 1;
    }
    else if (indexPath.section == 2){
        number = indexPath.row + 3;
    }
    else{
        number = 5;
    }
    return [self setCellImageName:imageName[number] text:text[number]];
    

}

- (UITableViewCell *) setCellImageName:(NSString *)imageName text:(NSString *)text
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",text];
    
    return cell;
}


//设置分组标题尾宽度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

//设置分组标题头宽度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
