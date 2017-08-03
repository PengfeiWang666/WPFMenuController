//
//  WPFMenuView.h
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
// warning:如果使用该控件，在合适的地方需要发送通知来告知该控件隐藏，比如当前页面消失、滑动 UITableView等

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MenuItemType) {
    MenuItemTypeCopy        = 1 << 0, // 复制
    MenuItemTypeTransmit    = 1 << 1, // 转发
    MenuItemTypeCollect     = 1 << 2, // 收藏
    MenuItemTypeDelete      = 1 << 3, // 删除
    MenuItemTypeRevoke      = 1 << 4, // 撤回
    MenuItemTypeDownload    = 1 << 5, // 下载
};

@protocol WPFMenuViewDelegate <NSObject>

@required
- (void)menuToThumbup;

@optional
- (void)menuToCopy;
- (void)menutoDelete;
- (void)menuToTransmit;
- (void)menuToDowanload;
- (void)menuToPreview;

@end

@interface WPFMenuView : UIView

@property (nonatomic, assign) MenuItemType itemType;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) id<WPFMenuViewDelegate> delegate;


- (void)setTargetRect:(CGRect)targetRect;

@end

