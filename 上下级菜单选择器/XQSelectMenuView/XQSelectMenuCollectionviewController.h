//
//  XQSelectMenuCollectionviewController.h
//  上下级菜单选择器
//
//  Created by 徐强 on 15/10/30.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XQSelectMenuCollectionviewControllerDelegate <NSObject>

@required
- (void)selectMenuDidClickAccessoryItemWithIndexpath:(NSIndexPath *)indexpath;
- (void)selectMenuDidClickMainItemWithIndexpath:(NSIndexPath *)indexpath;

@end

@interface XQSelectMenuCollectionviewController : UICollectionViewController

@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGFloat minimumLineSpacing;

@property (nonatomic, assign) CGFloat viewHeight;

/*** 辨别上下vc的mark **/
@property (nonatomic, assign) BOOL isMainVc;

@property (nonatomic, weak) id <XQSelectMenuCollectionviewControllerDelegate> delegate;

@end
