//
//  XQSelectMenuView.m
//  上下级菜单选择器
//
//  Created by 徐强 on 15/11/2.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import "XQSelectMenuView.h"
#import "XQSelectMenuCollectionviewController.h"

#define viewMargin 5

@interface XQSelectMenuView () <XQSelectMenuCollectionviewControllerDelegate>

@property (nonatomic, weak) UILabel *mainTitleLabel;
@property (nonatomic, weak) UILabel *accessoryTitleLabel;

@property (nonatomic, strong) XQSelectMenuCollectionviewController *mainVc;
@property (nonatomic, strong) XQSelectMenuCollectionviewController *accessoryVc;

@property (nonatomic, strong) NSMutableArray *mainDataArray;
@property (nonatomic, strong) NSMutableArray *accessoryDataArray;


@end

@implementation XQSelectMenuView
// view的搞得度为自动计算,此frame不能决定menu的高度,如果要自定义,请自行修改
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self addControl];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addControl];
    }
    return self;
}

- (void)addControl{
    
    self.backgroundColor = [UIColor whiteColor];
    UILabel *mainTitleLabel = [[UILabel alloc] init];
    UILabel *accessoryTitleLabel = [[UILabel alloc] init];
    
    mainTitleLabel.text = self.mainTitle;
    accessoryTitleLabel.text = self.accessoryTitle;
    
    self.clipsToBounds = !self.autoHeight;
    
    self.accessoryTitleLabel = accessoryTitleLabel;
    self.mainTitleLabel = mainTitleLabel;
    
    mainTitleLabel.font = [UIFont systemFontOfSize:14];
    accessoryTitleLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:mainTitleLabel];
    [self addSubview:accessoryTitleLabel];
    
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout2 setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout1.minimumInteritemSpacing = 5;
    flowLayout1.minimumLineSpacing = 10;
    flowLayout2.minimumInteritemSpacing = flowLayout1.minimumInteritemSpacing;
    flowLayout2.minimumLineSpacing = flowLayout1.minimumLineSpacing;
    
    XQSelectMenuCollectionviewController *mainVc = [[XQSelectMenuCollectionviewController alloc] initWithCollectionViewLayout:flowLayout1];
    XQSelectMenuCollectionviewController *accessoryVc = [[XQSelectMenuCollectionviewController alloc] initWithCollectionViewLayout:flowLayout2];
    
    mainVc.minimumLineSpacing = flowLayout1.minimumLineSpacing;
    mainVc.minimumInteritemSpacing = flowLayout1.minimumLineSpacing;
    
    accessoryVc.minimumLineSpacing = flowLayout2.minimumLineSpacing;
    accessoryVc.minimumInteritemSpacing = flowLayout2.minimumLineSpacing;
    
    mainVc.delegate = self;
    accessoryVc.delegate = self;
    
    mainVc.isMainVc = YES;
    
    self.mainVc = mainVc;
    self.accessoryVc = accessoryVc;
    
    [self addSubview:mainVc.view];
    [self addSubview:accessoryVc.view];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.mainTitleLabel sizeToFit];
    [self.accessoryTitleLabel sizeToFit];
    
    CGFloat titleHeight = self.mainTitleLabel.frame.size.height;
    
    self.mainTitleLabel.frame = CGRectMake(10, viewMargin, self.frame.size.width, titleHeight);
    
    self.mainVc.view.frame = CGRectMake(0, CGRectGetMaxY(self.mainTitleLabel.frame)+viewMargin, self.frame.size.width, self.mainVc.viewHeight);
    
    self.accessoryTitleLabel.frame = CGRectMake(10,CGRectGetMaxY(self.mainVc.view.frame)+viewMargin, self.frame.size.width, titleHeight);
    
    self.accessoryVc.view.frame = CGRectMake(0, CGRectGetMaxY(self.accessoryTitleLabel.frame)+viewMargin, self.frame.size.width+5,self.accessoryVc.viewHeight);
}

- (void)setMainDatasource:(NSArray *)mainDatasource{
    _mainDatasource = mainDatasource;
    self.mainVc.dataSourceArray = mainDatasource;
    self.mainDataArray = [[NSMutableArray alloc] initWithArray:mainDatasource];
    
    [self layoutIfNeeded];
    if (self.autoHeight) [self setMenuHeight];
}

- (void)setAccessoryDatasource:(NSArray *)accessoryDatasource{
    _accessoryDatasource = accessoryDatasource;
    self.accessoryVc.dataSourceArray = accessoryDatasource;
    self.accessoryDataArray = [[NSMutableArray alloc] initWithArray:accessoryDatasource];
    
    [self layoutIfNeeded];
    if (self.autoHeight) [self setMenuHeight];
}

- (void)setMainTitle:(NSString *)mainTitle{
    _mainTitle = mainTitle;
    self.mainTitleLabel.text = mainTitle;
    [self layoutIfNeeded];
    if (self.autoHeight) [self setMenuHeight];
}

- (void)setAccessoryTitle:(NSString *)accessoryTitle{
    _accessoryTitle = accessoryTitle;
    self.accessoryTitleLabel.text = accessoryTitle;
    [self layoutIfNeeded];
    if (self.autoHeight) [self setMenuHeight];
}

- (void)setAutoHeight:(BOOL)autoHeight{
    _autoHeight = autoHeight;
    [self setMainDatasource:_mainDatasource];
    [self setAccessoryDatasource:_accessoryDatasource];
}

- (void)setMenuHeight{
    
    CGRect frame = self.frame;
    CGFloat height = self.mainTitleLabel.frame.size.height + self.accessoryTitleLabel.frame.size.height + self.mainVc.view.frame.size.height + self.accessoryVc.view.frame.size.height + viewMargin * 4;
    
    if (frame.size.height != height) {
        frame.size.height = height;
        self.frame = frame;
        if ([self.delegate respondsToSelector:@selector(seleteMenuDidChangeHeight)]) {
            [self.delegate seleteMenuDidChangeHeight];
        }
    }
    frame.size.height = height;
    self.frame = frame;
    
}

#pragma maek - XQSelectMenuCollectionviewControllerDelegate
- (void)selectMenuDidClickMainItemWithIndexpath:(NSIndexPath *)indexpath{
    
    [self.accessoryDataArray addObject:self.mainDataArray[indexpath.row]];
    self.accessoryVc.dataSourceArray = self.accessoryDataArray;
    
    [self.mainDataArray removeObjectAtIndex:indexpath.row];
    self.mainVc.dataSourceArray = self.mainDataArray;
    
    [self layoutSubviews];
    [self setMenuHeight];
}

- (void)selectMenuDidClickAccessoryItemWithIndexpath:(NSIndexPath *)indexpath{
    
    [self.mainDataArray addObject:self.accessoryDataArray[indexpath.row]];
    self.mainVc.dataSourceArray = self.mainDataArray;
    
    [self.accessoryDataArray removeObjectAtIndex:indexpath.row];
    self.accessoryVc.dataSourceArray = self.accessoryDataArray;
    
    [self layoutSubviews];
    [self setMenuHeight];
    
}



@end
