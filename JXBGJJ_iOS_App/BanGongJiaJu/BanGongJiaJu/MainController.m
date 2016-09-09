//
//  MainController.m
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/8.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "MainController.h"
#import "HomeViewController.h"
#import "SuperViewController.h"
#import "BuyerCarViewController.h"
#import "MySettingViewController.h"



@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1-背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //设置子控制器
    [self setUpChildVC];
}


-(void)setUpChildVC
{
    
    //(1)首页
    [self addChildController:[[HomeViewController alloc] init] WithTitle:@"首页" WithImageName:@"v2_home"];
    
    //(2)超市
    [self addChildController:[[SuperViewController alloc] init] WithTitle:@"家具超市" WithImageName:@"v2_order"];
    
    //(3)购物车
    [self addChildController:[[BuyerCarViewController alloc] init] WithTitle:@"购物车" WithImageName:@"shopCart"];
    
    //(4)我
    [self addChildController:[[MySettingViewController alloc] init] WithTitle:@"我" WithImageName:@"v2_my"];
    
    

}


//根据图片和名来添加子控制器
-(void)addChildController:(UIViewController *)childVc WithTitle:(NSString *)title WithImageName:(NSString *)imageName
{
    childVc.title = title;
    
    //设置tabBar图片
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置点击图片
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_r",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置富文本文字
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    
    //添加到tabbarVC上
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:childVc]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
