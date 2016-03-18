//
//  QFExploreViewController.h
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFHomeViewController.h"


/**
 "发现"页面
 */
@interface QFExploreViewController : QFHomeViewController

@end


/**
 首页简单的List的数据项模型
 */
@interface QFSimpleListItem : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *iconName;
@property (nonatomic, assign) NSInteger type;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)iconName type:(NSInteger)type;

@end