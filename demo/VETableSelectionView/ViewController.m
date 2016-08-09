//
//  ViewController.m
//  VETableSelectionView
//
//  Created by zxw-lzq on 16/8/9.
//  Copyright © 2016年 msmeHewei. All rights reserved.
//

#import "ViewController.h"
#import "VESelectorView.h"


@interface ViewController ()<VESelectorViewDataSources,VESelectorViewDelegate>
@property (nonatomic,weak)VESelectorView *selectorView;
@property (nonatomic,strong)NSArray *dataSourcesArray;
@end

@implementation ViewController
- (NSArray *)dataSourcesArray{
    if (!_dataSourcesArray) {
        _dataSourcesArray = @[@"kami",@"saga",@"xiha",@"Heli",@"Luya"];
    }
    return _dataSourcesArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    VESelectorView *selectorView = [[VESelectorView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 50)];
    self.selectorView = selectorView;
    selectorView.dataSources = self;
    selectorView.delegate = self;
    
    [self.view addSubview:selectorView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(0, 100, self.view.bounds.size.width, 30)];
    [button setTitle:@"reload" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reloadClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (NSInteger)numberOfItemInSelectorView:(VESelectorView *)selectorView{
    
    return self.dataSourcesArray.count;
}
- (UIView *)selectorView:(UIView *)selectorView viewForItem:(UIView *)item atIndex:(NSInteger)index{
    UILabel *label = [[UILabel alloc]initWithFrame:item.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    label.text = [_dataSourcesArray objectAtIndex:index];
    label.font = [UIFont systemFontOfSize:12];
    if (index == 0) {
        label.textColor = [UIColor redColor];
    }
    
    
    
    return label;
}
- (void)selectorView:(VESelectorView *)selectorView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
    
    for (NSInteger i = 0; i < _dataSourcesArray.count; i++) {
        if (i == index) {
            UILabel *selectedlabel = (UILabel*)[selectorView itemForIndex:index];
            selectedlabel.textColor = [UIColor redColor];
            continue;
        }
        UILabel *label = (UILabel*)[selectorView itemForIndex:i];
        label.textColor = [UIColor lightGrayColor];
        
    }
}



- (void)reloadClick{
    
//    UIView *transView = [_selectorView itemForIndex:1];
//    for (UIView *subview in transView.subviews) {
//        [subview removeFromSuperview];
//    }
//    UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
//    newView.backgroundColor = [UIColor yellowColor];
//    [transView addSubview:newView];
    
    [self.selectorView reloadData];
}
@end
