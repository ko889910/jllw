//
//  TheHomeViewController.m
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/11.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "TheHomeViewController.h"
#import "HomeViewCell.h"


@interface TheHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


//1-自定义的navigationItem View
@property (nonatomic,weak) UIView *backView;

//2-下面的collectionView
@property (nonatomic,weak) UICollectionView *homeCollectionView;

//3-collectionView的flowLayout
@property (nonatomic,weak)UICollectionViewFlowLayout *flowLayout;


@end

@implementation TheHomeViewController

static NSString *collectionIdentifier = @"collectCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //将系统的NavigationController隐藏掉
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    //NavigationController的触发事件取消掉
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    //自定义navigationController
    [self setNav];
    
    
    //设置下面的collectionView
    [self setUpCollectionView];
    
}


//自定义navigationController上的View
-(void)setNav
{
    
    //1-背景View
    UIView *backView = [[UIView alloc] init];
    
    self.backView = backView;
    
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    
    //设置背景View的约束
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.leading.trailing.equalTo(self.view);
        
        make.height.equalTo(@80);
        
    }];
}

//设置下面的collectionView
-(void)setUpCollectionView
{
    
    //(1)实例化一个流水型布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.flowLayout = flowLayout;
    
    
    //设置行间距
    flowLayout.minimumLineSpacing = 0;
    
    //设置列间距
    flowLayout.minimumInteritemSpacing = 0;
    
    
    //设置cell的滚动方向(默认为垂直方向)
    //滚动方向改变之后,行内距和列内距设置就相反了
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    //(2)利用flowLayout来实例化一个collectionView
    //暂时把frame设置为zero，待会利用手动方式设置Auto Layout
    UICollectionView *homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    //设置背景
    homeCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.homeCollectionView = homeCollectionView;
    
    homeCollectionView.pagingEnabled = YES;
    homeCollectionView.bounces = NO;
    homeCollectionView.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:homeCollectionView];
    
    
    //(3)设置collectionView的layout
    [homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.backView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    //设置代理
    homeCollectionView.dataSource = self;
    
    homeCollectionView.delegate = self;
    
    
    //必须使用注册的方式来使用collection的cell
    [homeCollectionView registerClass:[HomeViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    
}

//布局子控件时设置flowLayout
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.flowLayout.itemSize = self.homeCollectionView.frame.size;
}

//实现collectionView的数据源方法
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
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    
    
    cell.num = indexPath.item;
    
    
    return cell;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
