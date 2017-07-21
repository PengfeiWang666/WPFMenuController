//
//  WPFMessage.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFMessage.h"
#import "WPFBaseTableViewCell.h"


@implementation WPFMessage

- (NSString *)identifier {
    if (!_identifier) {
        NSString *rawIdentifier = self.msgDirection == WPFMessageDirectionIncoming ? kCellIdentifierLeft : kCellIdentifierRight;
        _identifier = [NSString stringWithFormat:@"%@%@", rawIdentifier, [@(self.msgType) stringValue]];
    }
    return _identifier;
}

@end
