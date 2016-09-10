//
//  HomeViewCell.h
//  BanGongJiaJu
//
//  Created by 王炯 on 16/9/10.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableController.h"


@interface HomeViewCell : UICollectionViewCell


@property (nonatomic,strong)HomeTableController *vc;

@property (nonatomic,assign)NSInteger num;


@end
