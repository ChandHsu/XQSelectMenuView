//
//  ViewController.m
//  上下级菜单选择器
//
//  Created by 徐强 on 15/11/2.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import "ViewController.h"

#import "XQSelectMenuView.h"

@interface ViewController () <XQSelectMenuViewDelegate>

@property (nonatomic, weak) XQSelectMenuView *selectView;
@property (nonatomic, weak) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    XQSelectMenuView *selectView = [[XQSelectMenuView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,100)];
    [self.view addSubview:selectView];
    self.selectView = selectView;
    
    selectView.autoHeight = YES;
    
    selectView.mainDatasource = @[@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010",@"011",@"012",@"013",@"014",@"015",@"016",@"017",@"018",@"019",@"020",@"021",@"022",@"023",@"024",@"025",@"026",@"027"];
    
    selectView.accessoryDatasource =  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17"];
    
    selectView.mainTitle = @"主标题:";
    selectView.accessoryTitle = @"副标题:";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, CGRectGetMaxY(selectView.frame)+10, 20, 20);
    [self.view addSubview:btn];
    
    self.btn = btn;
    
    selectView.delegate = self;
    
}

- (void)seleteMenuDidChangeHeight{
    NSLog(@"高度改变了");
    
    self.btn.frame = CGRectMake(100, CGRectGetMaxY(self.selectView.frame)+10, 20, 20);
}

@end
