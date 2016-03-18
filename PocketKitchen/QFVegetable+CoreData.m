//
//  QFVegetable+CoreData.m
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetable+CoreData.h"
#import "GlobalDefine.h"

@implementation QFVegetable (CoreData)

+ (instancetype)vegetableWithData:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    // 获取数据的请求
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CD_ENTITY_NAME_VEGETABLE];
    NSString *vegetableID= data[@"vegetable_id"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"vegetable_id = %@", vegetableID];
    
    QFVegetable *vegetable = nil;
    
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
        vegetable = [NSEntityDescription insertNewObjectForEntityForName:CD_ENTITY_NAME_VEGETABLE inManagedObjectContext:context];
        
        [vegetable setValuesForKeysWithDictionary:data];
    }
    else {
        // 有且仅有一条数据
        vegetable = [matches firstObject];
        
        // 这里为了更新数据
        [vegetable setValuesForKeysWithDictionary:data];
    }

    return vegetable;
}

@end
