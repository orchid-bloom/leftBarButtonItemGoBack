//
//  QFCookbookSection.h
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFVegetable;

@interface QFCookbookSection : NSManagedObject

@property (nonatomic, retain) NSString * imageFilename;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * sortNumber;
@property (nonatomic, retain) NSOrderedSet *vegetables;
@end

@interface QFCookbookSection (CoreDataGeneratedAccessors)

- (void)insertObject:(QFVegetable *)value inVegetablesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromVegetablesAtIndex:(NSUInteger)idx;
- (void)insertVegetables:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeVegetablesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInVegetablesAtIndex:(NSUInteger)idx withObject:(QFVegetable *)value;
- (void)replaceVegetablesAtIndexes:(NSIndexSet *)indexes withVegetables:(NSArray *)values;
- (void)addVegetablesObject:(QFVegetable *)value;
- (void)removeVegetablesObject:(QFVegetable *)value;
- (void)addVegetables:(NSOrderedSet *)values;
- (void)removeVegetables:(NSOrderedSet *)values;
@end
