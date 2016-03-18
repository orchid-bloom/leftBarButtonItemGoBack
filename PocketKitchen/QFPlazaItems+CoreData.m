//
//  QFPlazaItems+CoreData.m
//  PocketKitchen
//
//  Created by Tema on 15/3/27.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPlazaItems+CoreData.h"
#import "GlobalDefine.h"
#import "QFPlazaComments+CoreData.h"

@implementation QFPlazaItems (CoreData)

+ (instancetype)plazaItemWithData:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    // 获取请求
    NSString *itemID = data[@"id"];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CD_ENTITY_NAME_PLAZAITEMS];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id = %@", itemID];
    
    QFPlazaItems *item= nil;
    
    // 执行数据请求操作
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:fetchRequest error:&error];
    
    // 如果有错误，处理错误
    if (error) {
        [QFErrorHandler handleError:error];
    }
    else if (!matches || matches.count > 1) {
        
        // 这是数据错误
        NSError *wrongDataError = [NSError errorWithDomain:ERROR_DOMAIN_COREDATA
                                                      code:ERROR_CODE_COREDATA_WRONGDATA
                                                  userInfo:@{NSLocalizedDescriptionKey: @"数据查询错误"}];
        [QFErrorHandler handleError:wrongDataError];
    }
    else if (matches.count == 0) {
        
        // 没有查到数据就插入一条数据
        item = [NSEntityDescription insertNewObjectForEntityForName:CD_ENTITY_NAME_PLAZAITEMS inManagedObjectContext:context];
        [item setValuesForKeysWithDictionary:data];
        
        // 同时去添加comments对象
        NSArray *comments = [data objectForKey:@"comments"];
        if (comments) {
            for (id obj in comments) {
                QFPlazaComments *comment = [QFPlazaComments plazaCommentWithData:obj inManagedObjectContext:context];
                comment.plazaItem = item;
            }
        }
    }
    else {
        
        // 有数据就更新数据
        item = [matches firstObject];
        [item setValuesForKeysWithDictionary:data];
        
        // 同时去更新comments对象
        NSArray *comments = [data objectForKey:@"comments"];
        if (comments) {
            for (id obj in comments) {
                QFPlazaComments *comment = [QFPlazaComments plazaCommentWithData:obj inManagedObjectContext:context];
                comment.plazaItem = item;
            }
        }
    }
    
    return item;
}

@end
