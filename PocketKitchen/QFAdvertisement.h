//
//  QFAdvertisement.h
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QFAdvertisement : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * imageFilename;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * enjoyVideoUrl;
@property (nonatomic, retain) NSString * videoImageFilename1;
@property (nonatomic, retain) NSString * videoImageFilename2;

@end
