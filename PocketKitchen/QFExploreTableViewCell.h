//
//  QFExploreTableViewCell.h
//  PocketKitchen
//
//  Created by Tema on 15/3/20.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 "发现"页面的Cell
 */
@interface QFExploreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotIcon;

@end
