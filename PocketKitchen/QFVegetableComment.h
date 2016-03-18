//
//  QFVegetableComment.h
//  PocketKitchen
//
//  Created by Tema on 15/5/24.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFVegetableComment : NSObject

@property (nonatomic, copy) NSString    *commentContent;
@property (nonatomic, copy) NSString    *commentTime;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *userId;
@property (nonatomic, copy) NSString    *userImage;
@property (nonatomic, copy) NSString    *username;
@property (nonatomic, copy) NSString    *vegetableCommentId;
@property (nonatomic, copy) NSString    *vegetableId;

@end

@interface QFVegetableComment (Create)

+ (instancetype)commentWithData:(id)data;

@end
