//
//  QFPlazaComments+CoreData.h
//  PocketKitchen
//
//  Created by Tema on 15/3/27.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPlazaComments.h"

@interface QFPlazaComments (CoreData)

/**
 根据数据来生成PlazaComments对象
 如果数据库中有PlazaComments对象，会把这个PlazaComments取出来，然后用新的更新它，并返回
 如果数据库中没有这个PlazaComments对象，那么会生成一个PlazaComments对象，并保存到数据库中
 
 @param data 用来初始化的数据，是一个NSDictionary 对象
 @param context 数据库的context
 @return 返回新生成的或数据库中的PlazaComments对象
 */
+ (instancetype)plazaCommentWithData:(NSDictionary *)data
              inManagedObjectContext:(NSManagedObjectContext *)context;

@end
