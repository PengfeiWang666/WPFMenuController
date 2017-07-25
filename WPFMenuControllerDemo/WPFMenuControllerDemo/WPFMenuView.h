//
//  WPFMenuView.h
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MenuItemType) {
    MenuItemTypeCopy        = 0,
    MenuItemTypeTransmit    = 1 << 0,
    MenuItemTypeCollect     = 1 << 1,
    MenuItemTypeDelete      = 1 << 2,
    MenuItemTypeRevoke      = 1 << 3,
    MenuItemTypeDownload    = 1 << 4,
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


- (void)setFrame:(CGRect)frame targetRect:(CGRect)targetRect;

@end

