//
//  QFVegetableVideoDetailCommentsView.h
//  PocketKitchen
//
//  Created by Tema on 15/5/23.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFVegetableVideoDetailCommentsView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (instancetype)commentsView;

- (void)refreshWithData:(id)commentsData;

@end
