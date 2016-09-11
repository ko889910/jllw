//
//  HomeTableController.m
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/10.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HomeTableController.h"

@interface HomeTableController ()

@end

@implementation HomeTableController

//初步布局
static NSString *identify = @"homeTableCell";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
}


-(void)setNum:(NSInteger)num
{
    _num = num;
    
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
//(1)组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger section = 2;
    
    if (self.num == 0)
    {
        section = 3;
    }
    
    return section;
}
//(2)行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
#warning 不固定，根据获取到的网络数据来设置行数
    NSInteger row = 13;
    
    
    if (section == 0)
    {
        row = 1;
    }
    else
    {
        if (self.num == 0)
        {
            if (section == 1)
            {
#warning 不固定，根据获取到的网络数据来设置行数
                row = 3;
            }
        }
    }

    return row;
}
//(3)行数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组第%ld行",(long)indexPath.section,(long)indexPath.row];
    
    
    
    return cell;
    
}



@end
