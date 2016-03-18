//
//  QFUser.m
//  PocketKitchen
//
//  Created by Tema on 15/5/4.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFUser.h"

@implementation QFUser


#pragma mark - UndefinedKey

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}


#pragma mark - Interface Methods


+ (instancetype)userWithData:(id)data
{
    QFUser *user = [[QFUser alloc] init];
    [user setValuesForKeysWithDictionary:data];
    
    return user;
}

@end
