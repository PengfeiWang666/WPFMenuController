//
//  WPFBaseTableViewCell.h
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPFMessage.h"
#import "WPFMenuView.h"

@class WPFBaseTableViewCell;

/*
 在从重用池出列时，修改的数据会作用到其他具有相同标识的待重用列上，所以需要用到两个标识避免数据错误
 */
static NSString *const kCellIdentifierLeft = @"ChatroomIdentifierLeft";
static NSString *const kCellIdentifierRight = @"ChatroomIdentifierRight";
static NSString *const WPFMenuControllerWillHideMenuNoti = @"WPFMenuControllerWillHideMenuNoti";

typedef NS_ENUM(NSUInteger, MessageAlignement) {
    MessageAlignementUndefined,
    MessageAlignementLeft,
    MessageAlignementRight
};

@interface WPFBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) MessageAlignement alignement;
@property (nonatomic, strong) WPFMessage *message;
@property (nonatomic, strong) UIImageView *bubbleView;
@property (nonatomic, strong) WPFMenuView *custormMenu;

- (void)buildCell;

@end
