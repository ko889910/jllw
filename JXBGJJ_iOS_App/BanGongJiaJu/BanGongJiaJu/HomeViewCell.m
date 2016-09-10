//
//  HomeViewCell.m
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/10.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HomeViewCell.h"

@implementation HomeViewCell

//在此初始化方法内对cell进行设置
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = RANDOMCOLOR;
        
        //加载一个tableView到cell中
        HomeTableController *vc = [[HomeTableController alloc] init];
        
        self.vc = vc;
        
        
        [self.contentView addSubview:vc.view];
        
        
    }
    return self;
}


//布局子界面，设置嵌入的tableView的大小
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.vc.view.frame = self.bounds;
}

//设置num
//重写num的set方法
-(void)setNum:(NSInteger)num
{
    _num = num;
    
    self.vc.num = num;
    
}


@end
