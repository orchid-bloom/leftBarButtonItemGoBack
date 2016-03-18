//
//  QFSimpleListCell.h
//  PocketKitchen
//
//  Created by Tema on 15/3/21.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFSimpleListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotIcon;

@end
