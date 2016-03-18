//
//  QFSearchCategoryItem.m
//  PocketKitchen
//
//  Created by Tema on 15/5/18.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFSearchCategoryItem.h"

@implementation QFSearchCategoryItem

+ (instancetype)itemWithName:(NSString *)name icon:(NSString *)iconName hlIcon:(NSString *)hlIconName
{
    QFSearchCategoryItem *item = [[QFSearchCategoryItem alloc] init];
    item.name = name;
    item.iconName = iconName;
    item.hlIconName = hlIconName;
    
    return item;
}

@end
