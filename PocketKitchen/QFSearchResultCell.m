//
//  QFSearchResultCell.m
//  PocketKitchen
//
//  Created by Tema on 15/5/21.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFSearchResultCell.h"

@implementation QFSearchResultCell

- (void)awakeFromNib {
    self.contentImageView.layer.borderWidth = 3;
    self.contentImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
