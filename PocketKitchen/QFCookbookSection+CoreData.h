//
//  QFCookbookSection+CoreData.h
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFCookbookSection.h"

@interface QFCookbookSection (CoreData)


/**
 根据数据来生成section对象
 如果数据库中有section对象，会把这个section取出来，然后用新的更新它，并返回
 如果数据库中没有这个section对象，那么会生成一个section对象，并保存到数据库中
 
 @param data 用来初始化的数据，是一个NSDictionary 对象
 @param context 数据库的context
 @return 返回新生成的或数据库中的section对象
 */
+ (QFCookbookSection *)sectionItemWithData:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;

@end
