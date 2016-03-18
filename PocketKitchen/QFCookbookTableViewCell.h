//
//  QFCookbookTableViewCell.h
//  PocketKitchen
//
//  Created by Tema on 15/3/6.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFTouchImageView.h"

@interface QFCookbookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sectionIcon;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;
@property (weak, nonatomic) IBOutlet UIButton *viewMoreBtn;

@property (weak, nonatomic) IBOutlet QFTouchImageView *sectionVideo0;
@property (weak, nonatomic) IBOutlet QFTouchImageView *sectionVideo1;
@property (weak, nonatomic) IBOutlet QFTouchImageView *sectionVideo2;

@property (weak, nonatomic) IBOutlet UILabel *videoTitle0;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle1;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle2;

@property (weak, nonatomic) IBOutlet UIImageView *videoPlayIcon0;
@property (weak, nonatomic) IBOutlet UIImageView *videoPlayIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *videoPlayIcon2;

@property (weak, nonatomic) IBOutlet UIImageView *dot0;
@property (weak, nonatomic) IBOutlet UIImageView *dot1;
@property (weak, nonatomic) IBOutlet UIImageView *dot2;

@property (weak, nonatomic) IBOutlet UIImageView *hotIcon;

@end
