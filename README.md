# XQSelectMenuView
##非常好用的上下级菜单选择器,简单快速集成

效果预览:

![](https://github.com/qianggeProgramer/XQSelectMenuView/blob/master/1.gif)

##用法
* 导入主头文件：`#import "XQSelectMenuView.h"`

```objc
// 创建XQSelectMenuView

    XQSelectMenuView *selectView = [[XQSelectMenuView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width,100)];
    [self.view addSubview:selectView];
    
// 设置数据源

    selectView.mainDatasource = @[@"001",@"002",@"003",@"004",@"005",@"006",@"007",@"008",@"009",@"010",@"011",@"012",@"013",@"014",@"015",@"016",@"017",@"018",@"019",@"020",@"021",@"022",@"023",@"024",@"025",@"026",@"027"];
    
    selectView.accessoryDatasource =  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17"];
    
// 设置主标题和副标题

    selectView.mainTitle = @"主标题:";
    selectView.accessoryTitle = @"副标题:";
```
XQSelectMenuView 支持自动适应高度:

```objc
    selectView.autoHeight = YES;
```

在自适应高度的情况下,实现其他控件对selectView依赖

1.遵守协议`<XQSelectMenuViewDelegate>`
2.设置代理:
```objc
    selectView.delegate = self;
    
- (void)seleteMenuDidChangeHeight{

    NSLog(@"高度改变了");
    
    self.btn.frame = CGRectMake(100, CGRectGetMaxY(self.selectView.frame)+10, 20, 20);
}
```
其中有很多不足的地方,如果有什么建议或意见,还请一起交流探讨,大家共同进步,我的联系方式  QQ:296646879


