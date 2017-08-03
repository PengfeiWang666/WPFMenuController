//
//  WPFTextTableViewCell.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFTextTableViewCell.h"
#import "Masonry.h"

@interface WPFTextTableViewCell ()

@property (nonatomic, strong) UILabel *textView;

@end

@implementation WPFTextTableViewCell


- (void)buildCell {
    [super buildCell];
    self.textView = [[UILabel alloc] init];
    self.textView.numberOfLines = 0;
//    self.textView.backgroundColor = [UIColor redColor];
    [self.textView setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [self.bubbleView addSubview:self.textView];
    
    if (self.alignement == MessageAlignementRight) {
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.edges.insets(UIEdgeInsetsMake(12, 16, 12, 21));
        }];
    } else {
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.edges.insets(UIEdgeInsetsMake(12, 21, 12, 16));
        }];
    }
    
//    [self.textView setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisVertical];
}

- (void)setMessage:(WPFMessage *)message {
    
    self.textView.text = message.msgBody;
    [self.textView sizeToFit];
    
    [super setMessage:message];
}



@end
