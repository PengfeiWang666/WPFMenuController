//
//  WPFMessage.h
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WPFMessageDirection) {
    WPFMessageDirectionIncoming,  // 收到的消息
    WPFMessageDirectionOutcoming, // 发出的消息
};

typedef NS_ENUM(NSUInteger, WPFMessageType) {
    WPFMessageTypeText,  // 文本类型消息
    WPFMessageTypeImage, // 图片类型消息
    WPFMessageTypeVoice, // 语音类型消息
};

@interface WPFMessage : NSObject

@property (nonatomic, copy) NSString *msgId;
@property (nonatomic, copy) NSString *msgBody;
@property (nonatomic, assign) WPFMessageDirection msgDirection;
@property (nonatomic, assign) WPFMessageType msgType;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *identifier;

@end
