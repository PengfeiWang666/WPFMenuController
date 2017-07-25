//
//  WPFMenuView.h
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MenuItemType) {
    MenuItemTypeThumbup     = 0,
    MenuItemTypeCopy        = 1 << 0,
    MenuItemTypeTransmit    = 1 << 1,
    MenuItemTypeDelete      = 1 << 2,
    MenuItemTypeDownload    = 1 << 3,
    MenuItemTypePreview     = 1 << 4,
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

