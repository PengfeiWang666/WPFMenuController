//
//  WPFTableView.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFTableView.h"
#import "WPFTextTableViewCell.h"
#import "WPFMessage.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface WPFTableView () <UITableViewDelegate, UITableViewDataSource>

/** 在这里数据源采用假数据的方式 */
@property (nonatomic, strong) NSMutableArray *messageData;

@end

@implementation WPFTableView

#pragma mark - build
- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self registerCell];
        [self setupUI];
        [self setupDelegate];
    }
    return self;
}

- (void)registerCell {
    //注册文本cell
    [self registerClass:[WPFTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@%ld", kCellIdentifierLeft, WPFMessageTypeText]];
    [self registerClass:[WPFTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@%ld", kCellIdentifierRight, WPFMessageTypeText]];
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:241/255.0 alpha:1];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fd_debugLogEnabled = NO;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    self.tableHeaderView = header;
}

- (void)setupDelegate {
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WPFMessage *message = self.messageData[indexPath.row];
    if (message.msgType == WPFMessageTypeText) {
        WPFTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:message.identifier];
        return textCell;
    } else {
        // 为以后其他类型预留
        WPFBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:message.identifier];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self configureCell:cell atIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView*)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {

    WPFMessage *message = self.messageData[indexPath.row];
    CGFloat height = message.height;
    
    if (!height) {
        CGFloat tableViewWidth = tableView.frame.size.width;
        __weak WPFTableView *weakSelf = self;
        if (tableViewWidth > 0){
            height = [self
                      fd_heightForCellWithIdentifier:message.identifier
                      cacheByIndexPath:indexPath
                      configuration:^(WPFBaseTableViewCell* cell) {
                          [weakSelf configureCell:cell atIndexPath:indexPath];
                      }];
        }
    }
    
    message.height = height;
    return height;
}

#pragma mark - Private Method

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    
    WPFMessage *message = self.messageData[indexPath.row];
    if (message.msgType == WPFMessageTypeText) {
        WPFTextTableViewCell *textCell = (WPFTextTableViewCell *)cell;
        textCell.message = message;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:WPFMenuControllerWillHideMenuNoti object:nil];
}

#pragma mark - setters && getters

- (NSMutableArray *)messageData {
    if (!_messageData) {
        _messageData = [NSMutableArray array];
        
        WPFMessage *message1 = [[WPFMessage alloc] init];
        message1.msgType = WPFMessageTypeText;
        message1.msgBody = @"测试数据";
        message1.msgDirection = WPFMessageDirectionIncoming;
        
        WPFMessage *message2 = [[WPFMessage alloc] init];
        message2.msgType = WPFMessageTypeText;
        message2.msgBody = @"这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据";
        message2.msgDirection = WPFMessageDirectionOutcoming;
        
        [_messageData addObject:message1];
        [_messageData addObject:message2];
    }
    return _messageData;
}






@end
