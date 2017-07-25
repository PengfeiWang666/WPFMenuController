//
//  WPFMenuView.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFMenuView.h"

#import "Masonry.h"
#import "UIColor+HexColor.h"
#import "UIButton+ImageTitleSpacing.h"

@interface WPFMenuView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIButton *revokeButton;
@property (nonatomic, strong) UIButton *copyingButton;
@property (nonatomic, strong) UIButton *transmitButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *collectButton;

@end

@implementation WPFMenuView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.arrowImageView];
    }
    return self;
}

#pragma mark - public method



#pragma - event response

- (void)setFrame:(CGRect)frame targetRect:(CGRect)targetRect {
    [super setFrame:frame];
    CGFloat arrowH = 8;
    CGFloat arrowW = 12;
    
    
    if (frame.origin.y > targetRect.origin.y) {
        // 箭头向上
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.top.mas_offset(arrowH);
        }];
        self.arrowImageView.image = [UIImage imageNamed:@"longpress_up_arrow"];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(arrowW);
            make.height.mas_equalTo(arrowH);
            make.top.equalTo(self);
            make.leading.mas_equalTo(targetRect.origin.x-frame.origin.x+0.5*targetRect.size.width);
        }];
    } else {
        // 箭头向下
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self);
            make.bottom.mas_offset(-arrowH);
        }];
        self.arrowImageView.image = [UIImage imageNamed:@"longpress_down_arrow"];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(arrowW);
            make.height.mas_equalTo(arrowH);
            make.bottom.equalTo(self);
            make.leading.mas_equalTo(targetRect.origin.x-frame.origin.x+0.5*targetRect.size.width-arrowW/2);
        }];
    }
}

- (void)thumbupButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToThumbup)]) {
        [self.delegate menuToThumbup];
    }
}

- (void)copyButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToCopy)]) {
        [self.delegate menuToCopy];
    }
}

- (void)transmitButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToTransmit)]) {
        [self.delegate menuToTransmit];
    }
}

- (void)deleteButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menutoDelete)]) {
        [self.delegate menutoDelete];
    }
}

- (void)downloadButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToDowanload)]) {
        [self.delegate menuToDowanload];
    }
}

- (void)previewButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToPreview)]) {
        [self.delegate menuToPreview];
    }
}


#pragma mark - setters && getters

- (void)setItemType:(MenuItemType)itemType {
    CGFloat buttonH = 54;
    CGFloat margin = 3;
    
    if (itemType == (MenuItemTypeTransmit | MenuItemTypeThumbup | MenuItemTypeCopy)) {//点、转、复
        self.itemCount = 3;
        // 针对别人发送的文本：拥有转发、点赞、复制的文本类型最多
        [self addSubview:self.revokeButton];
        [self addSubview:self.copyingButton];
        [self addSubview:self.transmitButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.copyingButton.mas_leading);
            make.width.equalTo(self.copyingButton);
        }];
        [self.copyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.copyingButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    } else if (itemType == (MenuItemTypeTransmit | MenuItemTypeThumbup)) {//点、转
        self.itemCount = 2;
        // 针对别人发的文件、照片、location：只有转发和点赞
        [self addSubview:self.revokeButton];
        [self addSubview:self.transmitButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.transmitButton.mas_leading);
            make.width.equalTo(self.transmitButton);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    } else if (itemType == (MenuItemTypeTransmit | MenuItemTypeThumbup | MenuItemTypeCopy | MenuItemTypeDelete)) {//点、转、复、删
        self.itemCount = 4;
        // 针对自己发送的文本和文件：全部都有
        [self addSubview:self.revokeButton];
        [self addSubview:self.copyingButton];
        [self addSubview:self.transmitButton];
        [self addSubview:self.deleteButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.copyingButton.mas_leading);
            make.width.equalTo(self.copyingButton);
        }];
        [self.copyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.copyingButton.mas_trailing);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.transmitButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    } else if (itemType == (MenuItemTypeTransmit | MenuItemTypeThumbup | MenuItemTypeDelete)) {//点、转、删
        self.itemCount = 3;
        // 针对自己发送的文件、照片、location：拥有转发、点赞、删除
        [self addSubview:self.revokeButton];
        [self addSubview:self.transmitButton];
        [self addSubview:self.deleteButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.transmitButton.mas_leading);
            make.width.equalTo(self.transmitButton);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.transmitButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    } else if (itemType == (MenuItemTypeThumbup | MenuItemTypeDelete)) {//点、删
        self.itemCount = 2;
        // 针对自己发送的语音：只有点赞和删除
        [self addSubview:self.revokeButton];
        [self addSubview:self.deleteButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.deleteButton.mas_leading);
            make.width.equalTo(self.deleteButton);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    } else if (itemType == MenuItemTypeThumbup) {//点
        self.itemCount = 1;
        // 针对别人发送的语音：只能点赞
        [self addSubview:self.revokeButton];
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
        }];
    } else if (itemType == (MenuItemTypeTransmit | MenuItemTypeThumbup | MenuItemTypeDelete | MenuItemTypePreview)) {//点、转、删、预
        self.itemCount = 4;
        [self addSubview:self.revokeButton];
        [self addSubview:self.deleteButton];
        [self addSubview:self.transmitButton];
        [self addSubview:self.collectButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.transmitButton.mas_leading);
            make.width.equalTo(self.transmitButton);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.transmitButton.mas_trailing);
        }];
        [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.deleteButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    } else if (itemType == (MenuItemTypeTransmit | MenuItemTypeThumbup | MenuItemTypeDownload)) {
        self.itemCount = 3;
        //点、转、下
        [self addSubview:self.revokeButton];
        [self addSubview:self.transmitButton];
        [self addSubview:self.downloadButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.transmitButton.mas_leading);
            make.width.equalTo(self.transmitButton);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.transmitButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    }else if (itemType == (MenuItemTypeThumbup | MenuItemTypeTransmit | MenuItemTypePreview)) {
        self.itemCount = 3;
        //点、转、预
        [self addSubview:self.revokeButton];
        [self addSubview:self.transmitButton];
        [self addSubview:self.collectButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.transmitButton.mas_leading);
            make.width.equalTo(self.transmitButton);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.transmitButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    }else if (itemType == (MenuItemTypeThumbup | MenuItemTypeTransmit | MenuItemTypeDelete | MenuItemTypeDownload)) {//点、转、删、下
        self.itemCount = 4;
        [self addSubview:self.revokeButton];
        [self addSubview:self.deleteButton];
        [self addSubview:self.transmitButton];
        [self addSubview:self.downloadButton];
        
        [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self.backgroundImageView).mas_offset(margin);
            make.height.mas_equalTo(buttonH);
            make.trailing.equalTo(self.transmitButton.mas_leading);
            make.width.equalTo(self.transmitButton);
        }];
        [self.transmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.revokeButton.mas_trailing);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.transmitButton.mas_trailing);
        }];
        [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(self.revokeButton);
            make.leading.equalTo(self.deleteButton.mas_trailing);
            make.trailing.equalTo(self);
        }];
    }
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"longpress_bg"];
    }
    return _backgroundImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
    }
    return _arrowImageView;
}

- (UIButton *)revokeButton {
    if (!_revokeButton) {
        _revokeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_revokeButton setTitle:@"点赞" forState:UIControlStateNormal];
        [_revokeButton setImage:[UIImage imageNamed:@"revoke"] forState:UIControlStateNormal];
        [_revokeButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_revokeButton setTitleColor:[UIColor colorWithHexaString:@"a5a4a71.00"] forState:UIControlStateNormal];
        [_revokeButton addTarget:self action:@selector(thumbupButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _revokeButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_deleteButton setTitleColor:[UIColor colorWithHexaString:@"a5a4a71.00"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _deleteButton;
}

- (UIButton *)copyingButton {
    if (!_copyingButton) {
        _copyingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_copyingButton setTitle:@"复制" forState:UIControlStateNormal];
        [_copyingButton setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        [_copyingButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_copyingButton setTitleColor:[UIColor colorWithHexaString:@"a5a4a71.00"] forState:UIControlStateNormal];
        [_copyingButton addTarget:self action:@selector(copyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_copyingButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _copyingButton;
}

- (UIButton *)transmitButton {
    if (!_transmitButton) {
        _transmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_transmitButton setTitle:@"转发" forState:UIControlStateNormal];
        [_transmitButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_transmitButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_transmitButton setTitleColor:[UIColor colorWithHexaString:@"a5a4a71.00"] forState:UIControlStateNormal];
        [_transmitButton addTarget:self action:@selector(transmitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_transmitButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _transmitButton;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        [_downloadButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_downloadButton setTitleColor:[UIColor colorWithHexaString:@"a5a4a71.00"] forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_downloadButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _downloadButton;
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setTitle:@"预览" forState:UIControlStateNormal];
        [_collectButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        [_collectButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_collectButton setTitleColor:[UIColor colorWithHexaString:@"a5a4a71.00"] forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(previewButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_collectButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _collectButton;
}

@end
