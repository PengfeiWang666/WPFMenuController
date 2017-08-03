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
// 如果需要适配 iOS8，自行用 Masonry 进行布局
@property (nonatomic, strong) UIStackView *containerView;
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

- (void)setTargetRect:(CGRect)targetRect {
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat itemW = 50;
    // 保证箭头在targetRect中心
    CGFloat targetCenterX = targetRect.origin.x + targetRect.size.width/2;
    CGFloat menuW = self.itemCount * itemW;
    CGFloat menuH = 58;
    CGFloat menuX = targetCenterX - menuW/2 > 0 ? targetCenterX - menuW/2 : 0;
    menuX = menuX + menuW > screenW ? screenW - menuW : menuX;
    CGFloat menuY = targetRect.origin.y - menuH;
    // 避免 MenuController 过于靠上
    menuY = menuY < 20 ? targetRect.origin.y + targetRect.size.height : menuY;
    // 适配特别长的文本，直接显示在屏幕中间
    menuY = menuY > screenH-menuH-30 ? screenH / 2 : menuY;
    
    CGRect frame = CGRectMake(menuX, menuY, menuW, menuH);
    
    [self setFrame:frame];
    CGFloat arrowH = 8;
    CGFloat arrowW = 12;
    CGFloat arrowX = targetRect.origin.x-frame.origin.x+0.5*targetRect.size.width-arrowW/2;
    
    if (frame.origin.y > targetRect.origin.y) {
        // 箭头向上
        self.backgroundImageView.frame = CGRectMake(0, arrowH, menuW, menuH-arrowH);
        self.arrowImageView.image = [UIImage imageNamed:@"longpress_up_arrow"];
        self.arrowImageView.frame = CGRectMake(arrowX, 0, arrowW, arrowH);
    } else {
        // 箭头向下
        self.backgroundImageView.frame = CGRectMake(0, 0, menuW, menuH-arrowH);
        self.arrowImageView.image = [UIImage imageNamed:@"longpress_down_arrow"];
        self.arrowImageView.frame = CGRectMake(arrowX, menuH-arrowH, arrowW, arrowH);
    }
}

- (void)thumbupButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToThumbup)]) {
        [self.delegate menuToThumbup];
    }
    [self removeFromSuperview];
}

- (void)copyButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToCopy)]) {
        [self.delegate menuToCopy];
    }
    [self removeFromSuperview];
}

- (void)transmitButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToTransmit)]) {
        [self.delegate menuToTransmit];
    }
    [self removeFromSuperview];
}

- (void)deleteButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menutoDelete)]) {
        [self.delegate menutoDelete];
    }
    [self removeFromSuperview];
}

- (void)downloadButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToDowanload)]) {
        [self.delegate menuToDowanload];
    }
    [self removeFromSuperview];
}

- (void)previewButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuToPreview)]) {
        [self.delegate menuToPreview];
    }
    [self removeFromSuperview];
}


#pragma mark - setters && getters

- (void)setItemType:(MenuItemType)itemType {
    [self.backgroundImageView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.backgroundImageView);
        make.top.equalTo(self.backgroundImageView).offset(8);
    }];
    
    if (itemType == (MenuItemTypeCopy | MenuItemTypeTransmit | MenuItemTypeCollect | MenuItemTypeDelete)) {
        self.itemCount = 4;
        
        [self.containerView addArrangedSubview:self.copyingButton];
        [self.containerView addArrangedSubview:self.transmitButton];
        [self.containerView addArrangedSubview:self.collectButton];
        [self.containerView addArrangedSubview:self.deleteButton];
    } else if (itemType == (MenuItemTypeCopy | MenuItemTypeTransmit | MenuItemTypeCollect | MenuItemTypeRevoke | MenuItemTypeDelete)) {
        self.itemCount = 5;
        
        [self.containerView addArrangedSubview:self.copyingButton];
        [self.containerView addArrangedSubview:self.transmitButton];
        [self.containerView addArrangedSubview:self.collectButton];
        [self.containerView addArrangedSubview:self.revokeButton];
        [self.containerView addArrangedSubview:self.deleteButton];
    } else {
        self.itemCount = 3;
    }
}

- (UIStackView *)containerView {
    if (!_containerView) {
        _containerView = [[UIStackView alloc] init];
        _containerView.alignment = UIStackViewAlignmentFill;
        _containerView.userInteractionEnabled = YES;
    }
    return _containerView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        UIImage *bgImage = [UIImage imageNamed:@"longpress_bg"];
        CGFloat left = bgImage.size.width * 0.5;
        CGFloat top = bgImage.size.height * 0.5;
        _backgroundImageView.image = [bgImage stretchableImageWithLeftCapWidth:left topCapHeight:top];
        _backgroundImageView.userInteractionEnabled = YES;
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
        [_revokeButton setTitle:@"撤回" forState:UIControlStateNormal];
        [_revokeButton setImage:[UIImage imageNamed:@"revoke"] forState:UIControlStateNormal];
        [_revokeButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_revokeButton setTitleColor:[UIColor colorWithHexaString:@"d4d4d41.00"] forState:UIControlStateNormal];
        [_revokeButton addTarget:self action:@selector(thumbupButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_revokeButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _revokeButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_deleteButton setTitleColor:[UIColor colorWithHexaString:@"d4d4d41.00"] forState:UIControlStateNormal];
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
        [_copyingButton setTitleColor:[UIColor colorWithHexaString:@"d4d4d41.00"] forState:UIControlStateNormal];
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
        [_transmitButton setTitleColor:[UIColor colorWithHexaString:@"d4d4d41.00"] forState:UIControlStateNormal];
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
        [_downloadButton setTitleColor:[UIColor colorWithHexaString:@"d4d4d41.00"] forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_downloadButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _downloadButton;
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        [_collectButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [_collectButton setTitleColor:[UIColor colorWithHexaString:@"d4d4d41.00"] forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(previewButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_collectButton wpf_setImagePosition:WPFImagePositionTop spacing:3];
    }
    return _collectButton;
}

@end
