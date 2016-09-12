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


//4-二维码扫描
@property (nonatomic,weak)UIButton *scanButton;

//5-搜索框View
@property (nonatomic,weak)UIView *searchView;

//6-城市定位信息按钮
@property (nonatomic,weak)UIButton *cityButton;

//7-城市右边的箭头
@property (nonatomic,weak)UIButton *arrowButton;

//8-3个控制collectionView的按钮
@property (nonatomic,weak)UIButton *midButton;

@property (nonatomic,weak)UIButton *leftButton;

@property (nonatomic,weak)UIButton *rightButton;

//9-button数组
@property (nonatomic,strong)NSArray<UIButton *> *buttonArray;

//10-添加一条线到button的下面
@property (nonatomic,weak)UIView *moveLine;



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
        
        make.height.equalTo(@95);
        
    }];
    
    
    //2-左边：扫一扫二维码
    UIButton *scanButton = [[UIButton alloc] init];
    
    self.scanButton = scanButton;
    
    //设置背景图片
    [scanButton setBackgroundImage:[UIImage imageNamed:@"icon_black_scancode"] forState:UIControlStateNormal];
    
    [scanButton sizeToFit];
    
    [backView addSubview:scanButton];
    
    //设置扫面二维码的约束
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        //make.centerY.equalTo(backView.mas_centerY);
        make.top.equalTo(backView.mas_top).offset(30);
        
        make.left.equalTo(backView).offset(15);
        
    }];
    
    //添加扫描二维码的点击触发事件
    [scanButton addTarget:self action:@selector(ScanQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //3-右边的城市定位信息(默认在上海)
    
    //3-1 添加一个箭头在城市右边
    UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.arrowButton = arrowButton;
    
    [arrowButton setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    
    [backView addSubview:arrowButton];
    
    //设置约束
    [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(scanButton.mas_centerY);
        
        make.right.equalTo(backView).offset(-15);
    }];
    
    
    UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.cityButton = cityButton;
    
    [cityButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cityButton setTitle:@"上海" forState:UIControlStateNormal];
    
    [backView addSubview:cityButton];
    
    //设置约束
    [cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(scanButton.mas_centerY);
        
        make.right.equalTo(arrowButton.mas_left).offset(-1);
        
    }];
    
    
    //添加城市选择的触发事件
    [arrowButton addTarget:self action:@selector(ChoseCity) forControlEvents:UIControlEventTouchUpInside];
    
    [cityButton addTarget:self action:@selector(ChoseCity) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    //4-中间的搜索框(不用searchBar，自定义View)
    //4.1 搜索框View
    UIView *searchView = [[UIView alloc] init];
    
    self.searchView = searchView;
    
    searchView.backgroundColor = RGBCOLOR(7, 170, 153);
    
    
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 12;
    [backView addSubview:searchView];
    
    //设置约束
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(scanButton.mas_centerY);
        
        
        make.left.equalTo(scanButton.mas_right).offset(20);
        
        make.right.equalTo(cityButton.mas_left).offset(-15);
        
        make.height.equalTo(@25);
        
    }];
    
    //4-2 添加搜索图标在搜索框里面
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_homepage_search"]];
    
    [searchImage sizeToFit];
    
    [searchView addSubview:searchImage];
    
    //设置约束
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.centerY.equalTo(searchView.mas_centerY);
        
        make.left.equalTo(searchView.mas_left).offset(5);
        
    }];
    
    //4-3 添加提示信息label到搜索框中
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    
    //字体大小
    placeHolderLabel.font = [UIFont boldSystemFontOfSize:12];
    
    //文字
    placeHolderLabel.text = @"请输入家具名、家具类型、家具厂商";
    
    //颜色
    placeHolderLabel.textColor = [UIColor whiteColor];
    
    [searchView addSubview:placeHolderLabel];
    
    //设置约束
    [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(searchView.mas_centerY);
        
        make.left.equalTo(searchImage.mas_right).offset(5);
    }];
    
    
    
    //5-加三个控制collectionView的按钮
    //5-1 中间的按钮
    UIButton *midButton = [[UIButton alloc] init];
    
    self.midButton = midButton;
    
    [midButton setTitle:@"家具2" forState:UIControlStateNormal];
    
    [midButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    //设置字体大小
    [midButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    
    [backView addSubview:midButton];
    
    //设置约束
    [midButton mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.centerX.equalTo(backView.mas_centerX);
        
        make.bottom.equalTo(backView.mas_bottom).offset(-5);
        
    }];
    
    
    
    
    
    
    //5-2 左边的按钮
    UIButton *leftButton = [[UIButton alloc] init];
    
    self.leftButton = leftButton;
    
    [leftButton setTitle:@"家具1" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    
    [backView addSubview:leftButton];
    
    //设置约束
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.bottom.equalTo(backView.mas_bottom).offset(-5);
        
        make.right.equalTo(midButton.mas_left).offset(-50);
    }];
    
    
    
    
    
    //5-3 右边的按钮
    UIButton *rightButton = [[UIButton alloc] init];
    
    self.rightButton = rightButton;
    
    [rightButton setTitle:@"家具3" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    
    [backView addSubview:rightButton];
    
    //设置约束
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(backView.mas_bottom).offset(-5);
        
        make.left.equalTo(midButton.mas_right).offset(50);
    }];
    
    
    //添加触发事件
    [midButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //添加触发事件
    [leftButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //添加触发事件
    [rightButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //6-添加一条线到button下面
    UIView *moveLine = [[UIView alloc] init];
    self.moveLine = moveLine;
    moveLine.backgroundColor = [UIColor blackColor];
    [backView addSubview:moveLine];
    
    [moveLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftButton.mas_bottom).offset(0.5);
        make.centerX.equalTo(leftButton.mas_centerX);
        make.height.equalTo(@2);
        //make.width.equalTo(@10);
        make.left.equalTo(backView).offset(80);
    }];
    
    
}


-(NSArray<UIButton *> *)buttonArray
{
    if (_buttonArray == nil)
    {
        _buttonArray = @[self.leftButton,self.midButton,self.rightButton];
    }
    
    return _buttonArray;
}



//二维码扫描的点击触发事件
-(void)ScanQRCode
{
    NSLog(@"二维码扫描了");
}

//城市选择点击触发事件
-(void)ChoseCity
{
    NSLog(@"选择城市");
}

//3个button的按钮触发事件
-(void)ClickButton:(UIButton *)button
{
    
    //点击的button字体变成黑色
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        
        if (obj != button)
        {
            [obj setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        else
        {
            //collection滚动到响应的cell
            [weakSelf.homeCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            
            
            //moveLine的滑动
            //判断是不是第一个
            if (idx == 0)
            {
                self.moveLine.transform = CGAffineTransformIdentity;
            }
            else
            {
                
                //moveLine的滑动距离
                CGFloat moveX = (50 + self.midButton.bounds.size.width) * idx;
                
                //moveLine滑动
                self.moveLine.transform =CGAffineTransformMakeTranslation(moveX, 0);
            }
            
        }
    
    }];
    
}


-(void)ClickButtonWith:(NSInteger )buttonIndex
{
    
    UIButton *clickButton = self.buttonArray[buttonIndex];
    
    
    
    //点击的button字体变成黑色
    [clickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        
        if (obj != clickButton)
        {
            [obj setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        
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


//(4)当手动拖拽collectionView时的触发事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat scale = scrollView.contentOffset.x / self.homeCollectionView.bounds.size.width;
    
    
    //moveLine的滑动距离
    CGFloat moveX = (50 + self.midButton.bounds.size.width) * scale;
    
    //moveLine运动
    _moveLine.transform = CGAffineTransformMakeTranslation(moveX, 0);
}

//(5)当手动拖拽完成之后的触发事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/self.homeCollectionView.bounds.size.width;
    
    
    [self ClickButtonWith:index];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
