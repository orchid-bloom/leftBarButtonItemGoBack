//
//  QFVegetableDetailCommentCell.m
//  PocketKitchen
//
//  Created by Tema on 15/5/24.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetableDetailCommentCell.h"

@implementation QFVegetableDetailCommentCell

- (void)awakeFromNib {
    self.headPortraitImageView.layer.cornerRadius = 30.0f;
    self.headPortraitImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
