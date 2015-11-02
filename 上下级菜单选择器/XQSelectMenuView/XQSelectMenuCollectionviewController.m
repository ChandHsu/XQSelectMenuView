//
//  XQSelectMenuCollectionviewController.m
//  上下级菜单选择器
//
//  Created by 徐强 on 15/10/30.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import "XQSelectMenuCollectionviewController.h"
#import "XQSelectMenuItem.h"

#define itemHeight 30
#define itemWidth 50

@interface XQSelectMenuCollectionviewController ()

@end

@implementation XQSelectMenuCollectionviewController

- (void)setDataSourceArray:(NSArray *)dataSourceArray{
    _dataSourceArray = dataSourceArray;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
}

static NSString * const reuseIdentifier = @"SelectMenuCollectionviewControllerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    int lineCount = self.view.frame.size.width/(itemWidth+self.minimumInteritemSpacing);
    
    self.viewHeight = 10 + self.dataSourceArray.count/lineCount * (itemHeight + self.minimumLineSpacing);
    
    if (self.dataSourceArray.count % lineCount > 0) {
        self.viewHeight = self.viewHeight + itemHeight + self.minimumLineSpacing;
    }
    
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    XQSelectMenuItem *item = [[XQSelectMenuItem alloc] init];
    item.labelText = self.dataSourceArray[indexPath.row];
    cell.backgroundView = item;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(itemWidth, itemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isMainVc) {
        if ([self.delegate respondsToSelector:@selector(selectMenuDidClickMainItemWithIndexpath:)]) {
            [self.delegate selectMenuDidClickMainItemWithIndexpath:indexPath];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(selectMenuDidClickAccessoryItemWithIndexpath:)]) {
            [self.delegate selectMenuDidClickAccessoryItemWithIndexpath:indexPath];
        }
    }
    
    
}
@end
