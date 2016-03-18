//
//  QFPlazaCollectionViewCell.h
//  PocketKitchen
//
//  Created by Tema on 15/3/26.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFPlazaCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;



@end
