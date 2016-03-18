//
//  QFVegetable.m
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetable.h"
#import "QFCookbookSection.h"
#import "GlobalDefine.h"


@implementation QFVegetable

@dynamic agreementAmount;
@dynamic catalogId;
@dynamic clickCount;
@dynamic cookingMethod;
@dynamic cookingWay;
@dynamic downloadCount;
@dynamic effect;
@dynamic englishName;
@dynamic fittingCrowd;
@dynamic fittingRestriction;
@dynamic imagePathLandscape;
@dynamic imagePathPortrait;
@dynamic imagePathThumbnails;
@dynamic is_collect;
@dynamic is_purchase;
@dynamic isCelebritySelf;
@dynamic materialVideoPath;
@dynamic method;
@dynamic name;
@dynamic price;
@dynamic productionProcessPath;
@dynamic taste;
@dynamic timeLength;
@dynamic vegetable_id;
@dynamic vegetableCookingId;
@dynamic section;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (NSString *)description
{
    return ObjcDescription(self);
}

@end
