//
//  QFVegetableComment.m
//  PocketKitchen
//
//  Created by Tema on 15/5/24.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetableComment.h"
#import "GlobalDefine.h"

@implementation QFVegetableComment


#pragma mark - UndefinedKey


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

#pragma mark - Interface Methods


+ (instancetype)commentWithData:(id)data
{
    QFVegetableComment *comment = [[QFVegetableComment alloc] init];
    [comment setValuesForKeysWithDictionary:data];
    
    return comment;
}

@end
