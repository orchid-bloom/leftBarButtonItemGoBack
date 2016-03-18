//
//  QFPlazaComments.h
//  PocketKitchen
//
//  Created by Tema on 15/3/27.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QFPlazaItems;

@interface QFPlazaComments : NSManagedObject

@property (nonatomic, retain) NSString * commentDate;
@property (nonatomic, retain) NSString * commentUserId;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPortraitImageFileName;
@property (nonatomic, retain) QFPlazaItems *plazaItem;

@end
