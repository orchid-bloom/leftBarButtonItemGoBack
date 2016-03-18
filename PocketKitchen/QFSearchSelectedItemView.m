//
//  QFSearchSelectedItemView.m
//  PocketKitchen
//
//  Created by Tema on 15/5/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFSearchSelectedItemView.h"

@implementation QFSearchSelectedItemView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title delegate:(id<QFSearchSelectedItemViewDelegate>)delegate userInfo:(id)userInfo
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInfo = userInfo;
        self.delegate = delegate;
        
        // 标题的Label
        CGFloat titleWidth = frame.size.width * 0.7;
        CGFloat btnWidth = frame.size.width - titleWidth;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, frame.size.height)];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
        if (title.length > 4) {
            _titleLabel.adjustsFontSizeToFitWidth = YES;
        }
        else {
            _titleLabel.adjustsFontSizeToFitWidth = NO;
            _titleLabel.font = [UIFont systemFontOfSize:16];
        }
        [self addSubview:_titleLabel];
        
        // 移除的按钮
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeButton.frame = CGRectMake(titleWidth, 0, btnWidth, frame.size.height);
        [_removeButton setImage:[UIImage imageNamed:@"search_header_rmbtn"] forState:UIControlStateNormal];
        [_removeButton setImage:[UIImage imageNamed:@"search_header_rmbtn_hl"] forState:UIControlStateHighlighted];
        [_removeButton addTarget:self action:@selector(removeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_removeButton];
        
        // self的设置
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor colorWithRed:235/255.0f green:221/255.0f blue:186/255.0f alpha:1.0f];
        self.layer.cornerRadius = 5.0f;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title userInfo:(id)userInfo
{
    _titleLabel.text = title;
    self.userInfo = userInfo;
    
    if (title.length > 4) {
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    else {
        _titleLabel.adjustsFontSizeToFitWidth = NO;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
}


#pragma mark - Event Handlers


- (void)removeBtnClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(itemViewDidClickedRemoveButton:)]) {
        [self.delegate itemViewDidClickedRemoveButton:self];
    }
}

@end
