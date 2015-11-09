//
//  XQSelectMenuViewFlowLayout.m
//  上下级菜单选择器
//
//  Created by 徐强 on 15/11/9.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import "XQSelectMenuViewFlowLayout.h"

@implementation XQSelectMenuViewFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for(int i = 1; i < [attributes count]; ++i) {
        
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        
        NSInteger maximumSpacing = self.maximumSpacing;
        
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        
        //防止单行显示
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end
