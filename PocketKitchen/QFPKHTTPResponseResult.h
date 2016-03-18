//
//  QFPKHTTPResponseResult.h
//  PocketKitchen
//
//  Created by Tema on 15/3/9.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 请求里面的数据表头信息，包括数据统计信息
 */
@interface QFPKHTTPResponseResultBean : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy)     NSString        *curPage;
@property (nonatomic, copy)     NSString        *maxPageNumber;
@property (nonatomic, copy)     NSString        *nextPageNumber;
@property (nonatomic, copy)     NSString        *pageRecord;
@property (nonatomic, copy)     NSString        *paginate;
@property (nonatomic, retain)   NSDictionary    *parameters;
@property (nonatomic, copy)     NSString        *previousPageNumber;
@property (nonatomic, copy)     NSString        *startRecordIndex;
@property (nonatomic, copy)     NSString        *totalRecord;
@property (nonatomic, copy)     NSString        *url;

- (id)initWithJSON:(id)jsonObj;

@end


/**
 这个项目中网络请求返回的格式模型
 */
@interface QFPKHTTPResponseResult : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy)     NSString    *status;
@property (nonatomic, copy)     NSString    *message;
@property (nonatomic, retain)   id          data;

@property (nonatomic, retain)   QFPKHTTPResponseResultBean  *bean;

- (id)initWithJSON:(id)jsonObj;

@end
