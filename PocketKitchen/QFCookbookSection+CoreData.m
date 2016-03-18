//
//  QFCookbookSection+CoreData.m
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFCookbookSection+CoreData.h"
#import "GlobalDefine.h"
#import "QFVegetable+CoreData.h"

@implementation QFCookbookSection (CoreData)

+ (QFCookbookSection *)sectionItemWithData:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    // 获取数据的请求
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CD_ENTITY_NAME_COOKBOOKSECTION];
    NSString *type = data[@"type"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"type = %@", type];
    
    QFCookbookSection *sectionItem = nil;
    
    // 数据获取
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        [QFErrorHandler handleError:error];
    }
    else if (!matches || [matches count] > 1) {
        
        // 数据不对
        NSError *wrongDataError = [NSError errorWithDomain:ERROR_DOMAIN_COREDATA
                                                      code:ERROR_CODE_COREDATA_WRONGDATA
                                                  userInfo:@{NSLocalizedDescriptionKey: @"查询到的数据错误"}];
        [QFErrorHandler handleError:wrongDataError];
    }
    else if ([matches count] == 0) {
        // 没有数据，就插入一条数据
        sectionItem = [NSEntityDescription insertNewObjectForEntityForName:CD_ENTITY_NAME_COOKBOOKSECTION inManagedObjectContext:context];
        
        [sectionItem setValuesForKeysWithDictionary:data];
        
        // 同时去添加vegetable对象
        NSArray *vegetableList = [data objectForKey:@"vegetableList"];
        if (vegetableList) {
            for (id obj in vegetableList) {
                QFVegetable *vegetable = [QFVegetable vegetableWithData:obj inManagedObjectContext:context];
                vegetable.section = sectionItem;
            }
        }
    }
    else {
        // 有且仅有一条数据
        sectionItem = [matches firstObject];
        
        // 这里为了更新数据
        [sectionItem setValuesForKeysWithDictionary:data];
        
        // 同时去添加vegetable对象
        NSArray *vegetableList = [data objectForKey:@"vegetableList"];
        if (vegetableList) {
            for (id obj in vegetableList) {
                QFVegetable *vegetable = [QFVegetable vegetableWithData:obj inManagedObjectContext:context];
                vegetable.section = sectionItem;
            }
        }
    }
    
    return sectionItem;
}

@end
