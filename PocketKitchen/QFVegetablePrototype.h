//
//  QFVegetablePrototype.h
//  PocketKitchen
//
//  Created by Tema on 15/5/21.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFVegetable.h"


/**
 菜单的原型，这个原型不会存储到数据库中
 */
@interface QFVegetablePrototype : NSObject

@property (nonatomic, copy) NSString * agreementAmount;
@property (nonatomic, copy) NSString * catalogId;
@property (nonatomic, copy) NSString * clickCount;
@property (nonatomic, copy) NSString * cookingMethod;
@property (nonatomic, copy) NSString * cookingWay;
@property (nonatomic, copy) NSString * downloadCount;
@property (nonatomic, copy) NSString * effect;
@property (nonatomic, copy) NSString * englishName;
@property (nonatomic, copy) NSString * fittingCrowd;
@property (nonatomic, copy) NSString * fittingRestriction;
@property (nonatomic, copy) NSString * imagePathLandscape;
@property (nonatomic, copy) NSString * imagePathPortrait;
@property (nonatomic, copy) NSString * imagePathThumbnails;
@property (nonatomic, copy) NSString * is_collect;
@property (nonatomic, copy) NSString * is_purchase;
@property (nonatomic, copy) NSString * isCelebritySelf;
@property (nonatomic, copy) NSString * materialVideoPath;
@property (nonatomic, copy) NSString * method;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * productionProcessPath;
@property (nonatomic, copy) NSString * taste;
@property (nonatomic, copy) NSString * timeLength;
@property (nonatomic, copy) NSString * vegetable_id;
@property (nonatomic, copy) NSString * vegetableCookingId;

@end


/**
 快速创建QFVegetablePrototype对象的Category
 */
@interface QFVegetablePrototype (Create)

/**
 根据数据来创建一个VegetablePrototype对象
 */
+ (instancetype)vegetableWithData:(id)data;


/**
 根据QFVegetable对象来生成QFVegetablePrototype对象
 */
+ (instancetype)vegetableFrom:(QFVegetable *)v;

@end
