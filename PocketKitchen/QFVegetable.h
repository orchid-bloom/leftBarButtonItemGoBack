//
//  QFVegetable.h
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFCookbookSection;

@interface QFVegetable : NSManagedObject

@property (nonatomic, retain) NSString * agreementAmount;
@property (nonatomic, retain) NSString * catalogId;
@property (nonatomic, retain) NSString * clickCount;
@property (nonatomic, retain) NSString * cookingMethod;
@property (nonatomic, retain) NSString * cookingWay;
@property (nonatomic, retain) NSString * downloadCount;
@property (nonatomic, retain) NSString * effect;
@property (nonatomic, retain) NSString * englishName;
@property (nonatomic, retain) NSString * fittingCrowd;
@property (nonatomic, retain) NSString * fittingRestriction;
@property (nonatomic, retain) NSString * imagePathLandscape;
@property (nonatomic, retain) NSString * imagePathPortrait;
@property (nonatomic, retain) NSString * imagePathThumbnails;
@property (nonatomic, retain) NSString * is_collect;
@property (nonatomic, retain) NSString * is_purchase;
@property (nonatomic, retain) NSString * isCelebritySelf;
@property (nonatomic, retain) NSString * materialVideoPath;
@property (nonatomic, retain) NSString * method;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * productionProcessPath;
@property (nonatomic, retain) NSString * taste;
@property (nonatomic, retain) NSString * timeLength;
@property (nonatomic, retain) NSString * vegetable_id;
@property (nonatomic, retain) NSString * vegetableCookingId;
@property (nonatomic, retain) QFCookbookSection *section;

@end
