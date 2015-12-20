//
//  WBDiscoverViewController.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBDiscoverViewController.h"
#import "WBSearchBar.h"

@interface WBDiscoverViewController ()

@end

@implementation WBDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    WBSearchBar *searchBar = [[WBSearchBar alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 35)];
    searchBar.placeholder = @"大家都在搜";
    
    self.navigationItem.titleView = searchBar;
    
    
}

//结束搜索栏编辑状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationItem.titleView endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number;
    
    if (section == 0) {
        number = 2;
    }
    else if (section == 1){
        number = 2;
    }
    else if(section == 2){
        number = 3;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *text = [[NSArray alloc]initWithObjects:@"热门微博",@"找人",@"游戏中心",@"周边",@"听歌",@"电影",@"更多频道", nil];
    NSArray *imageName = [[NSArray alloc]initWithObjects:@"hot_status",@"find_people",@"game_center",@"near",@"music",@"movie",@"more", nil];
    NSInteger number;
    if (indexPath.section == 0) {
        number = indexPath.row;
    }
    else if (indexPath.section == 1){
        number = indexPath.row + 2;
    }
    else if(indexPath.section == 2){
        number = indexPath.row + 4;
    }
    
    return [self setCellImageName:imageName[number] text:text[number]];
}

//给cell赋值
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
