//
//  WBNewFetureController.m
//  新浪微博项目
//
//  Created by neng on 15/10/1.
//  Copyright © 2015年 neng. All rights reserved.
//

#import "WBNewFetureController.h"
#import "WBNewFetureCell.h"

@interface WBNewFetureController ()

///分页控件
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation WBNewFetureController

//重写构造方法,把布局方式封装在里面
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    //清空行距
    layout.minimumLineSpacing = 0;
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
    
}

static NSString * const reuseIdentifier = @"Cell";

//self.collectionView != self.view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在这里注册了什么cell就会默认创建什么cell
    [self.collectionView registerClass:[WBNewFetureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //设置分页、滚动弹性、横向滚动条
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //添加分页
    [self setUpPageControl];
}

///添加分页
- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 20);
    
    _pageControl = pageControl;
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollView代理 因为collectionController已经遵守了，所以不用再写
- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{
    //计算当前页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    _pageControl.currentPage = page;
    
}

#pragma mark <UICollectionViewDataSource>
//返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}
//一组有几个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
//每个长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     1.首先会从缓存池取cell
     2.看先有没有注册cell,有创建cell
     3.没有就报错
     */
    WBNewFetureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //设置cell的属性
    // 拼接图片名称 3.5 320 480
    //为了适应屏幕 要把图片放在Supporting Files下，不然找不到
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    if (screenH > 480) { // 5 , 6 , 6 plus
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
    cell.image = [UIImage imageNamed:imageName];
    
    //判断是否最后一页
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}


@end
