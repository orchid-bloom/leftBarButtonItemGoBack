//
//  QFCookbookSection.m
//  PocketKitchen
//
//  Created by Tema on 15/3/19.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFCookbookSection.h"
#import "QFVegetable.h"


@implementation QFCookbookSection

@dynamic imageFilename;
@dynamic name;
@dynamic type;
@dynamic sortNumber;
@dynamic vegetables;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
