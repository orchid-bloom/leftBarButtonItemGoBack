//
//  QFVegetableVideoDetailHeader.h
//  PocketKitchen
//
//  Created by Tema on 15/5/22.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFVegetableVideoDetailHeader : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel                *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView            *backgroundImageView;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign) NSInteger              section;

@end
