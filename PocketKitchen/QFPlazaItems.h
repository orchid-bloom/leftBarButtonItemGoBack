//
//  QFPlazaItems.h
//  PocketKitchen
//
//  Created by Tema on 15/3/27.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFPlazaComments;

@interface QFPlazaItems : NSManagedObject

@property (nonatomic, retain) NSString * auditDate;
@property (nonatomic, retain) NSString * collectionCount;
@property (nonatomic, retain) NSString * commentCount;
@property (nonatomic, retain) NSString * hotlist;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * imageFileName;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * lastReplayDate;
@property (nonatomic, retain) NSString * liked;
@property (nonatomic, retain) NSString * shareCount;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPortraitImageFileName;
@property (nonatomic, retain) NSString * video;
@property (nonatomic, retain) NSString * viewCount;
@property (nonatomic, retain) NSOrderedSet *commentsArr;
@end

@interface QFPlazaItems (CoreDataGeneratedAccessors)

- (void)insertObject:(QFPlazaComments *)value inCommentsArrAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentsArrAtIndex:(NSUInteger)idx;
- (void)insertCommentsArr:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentsArrAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentsArrAtIndex:(NSUInteger)idx withObject:(QFPlazaComments *)value;
- (void)replaceCommentsArrAtIndexes:(NSIndexSet *)indexes withCommentsArr:(NSArray *)values;
- (void)addCommentsArrObject:(QFPlazaComments *)value;
- (void)removeCommentsArrObject:(QFPlazaComments *)value;
- (void)addCommentsArr:(NSOrderedSet *)values;
- (void)removeCommentsArr:(NSOrderedSet *)values;
@end
