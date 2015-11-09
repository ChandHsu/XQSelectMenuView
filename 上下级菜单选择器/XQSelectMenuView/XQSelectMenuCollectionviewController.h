//
//  XQSelectMenuCollectionviewController.h
//  上下级菜单选择器
//
//  Created by 徐强 on 15/10/30.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define  iPhone4     ([[UIScreen mainScreen] bounds].size.height==480)
#define  iPhone5     ([[UIScreen mainScreen] bounds].size.height==568)
#define  iPhone6     ([[UIScreen mainScreen] bounds].size.height==667)
#define  iPhone6plus ([[UIScreen mainScreen] bounds].size.height==736)
#define  iPad        ([[UIScreen mainScreen] bounds].size.height>736)

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
