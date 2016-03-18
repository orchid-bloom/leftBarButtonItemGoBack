//
//  QFVegetablePrototype.m
//  PocketKitchen
//
//  Created by Tema on 15/5/21.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetablePrototype.h"
#import "GlobalDefine.h"

@implementation QFVegetablePrototype


+ (instancetype)vegetableWithData:(id)data
{
    QFVegetablePrototype *vegetable = [[QFVegetablePrototype alloc] init];
    [vegetable setValuesForKeysWithDictionary:data];
    
    return vegetable;
}

+ (instancetype)vegetableFrom:(QFVegetable *)v
{
    QFVegetablePrototype *vegetable = [[QFVegetablePrototype alloc] init];
    for (NSString *propertyName in [vegetable propertyList]) {
        NSString *value = [v valueForKey:propertyName];
        [vegetable setValue:value forKey:propertyName];
    }
    
    return vegetable;
}


#pragma mark - UndefinedKey


- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return ObjcDescription(self);
}

@end
