//
//  MainController.m
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/8.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "MainController.h"

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
    
    

}


//根据图片和名来设置子控制器



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
