//
//  ViewController.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFViewController.h"
#import "WPFTableView.h"
#import "Masonry.h"

@interface WPFViewController ()

@property (nonatomic, strong) WPFTableView *tableView;

@end

@implementation WPFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"假的聊天页面";
    [self _setupUI];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WPFMenuControllerWillHideMenuNoti" object:nil];
}

#pragma mark - Private Method
- (void)_setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - setters && getters
- (WPFTableView *)tableView {
    if (!_tableView) {
        _tableView = [[WPFTableView alloc] init];
        
    }
    return _tableView;
}


@end
