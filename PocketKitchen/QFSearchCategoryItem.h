//
//  QFSearchCategoryItem.h
//  PocketKitchen
//
//  Created by Tema on 15/5/18.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFSearchCategoryItem : NSObject

@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *iconName;
@property (nonatomic, copy) NSString    *hlIconName;

@end

/**
 QFSearchCategoryItem 快速创建对象的Category
 */
@interface QFSearchCategoryItem (Create)

/**
 快速创建 QFSearchCategoryItem 对象
 */
+ (instancetype)itemWithName:(NSString *)name icon:(NSString *)iconName hlIcon:(NSString *)hlIconName;

@end
