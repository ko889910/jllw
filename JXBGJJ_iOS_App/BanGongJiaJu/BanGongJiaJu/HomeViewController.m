//
//  HomeViewController.m
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/8.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewCell.h"


@interface HomeViewController ()


//collectionView全局flowLayout属性
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;



@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"HomeCell";


//重写init方法调整collectionView布局
-(instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout = flowLayout;
    
    //设置flowLayout
    //设置行间距
    flowLayout.minimumLineSpacing = 0;
    
    //设置列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    //设置内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    
    
    //设置cell的大小
    flowLayout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height - 64);
    
    
    //设置cell的滚动方向(默认为垂直方向)
    //滚动方向改变之后,行内距和列内距设置就相反了
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    return [super initWithCollectionViewLayout:flowLayout];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"";
    
    //初始化collectionView
    [self SetUpCollectionView];
    
    
    // Register cell classes
    [self.collectionView registerClass:[HomeViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//设置collectionView的一些属性
-(void)SetUpCollectionView
{
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}

//布局子控件时设置flowLayout
/*
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.flowLayout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height - 64);
}
*/

//数据源代理代理方法
//1-组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//2-item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

//3-item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
