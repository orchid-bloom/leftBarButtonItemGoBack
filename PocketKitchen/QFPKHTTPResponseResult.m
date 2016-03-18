//
//  QFPKHTTPResponseResult.m
//  PocketKitchen
//
//  Created by Tema on 15/3/9.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPKHTTPResponseResult.h"
#import "DPUtility.h"


@implementation QFPKHTTPResponseResultBean

- (void)dealloc
{
    self.curPage = nil;
    self.maxPageNumber = nil;
    self.nextPageNumber = nil;
    self.pageRecord = nil;
    self.paginate = nil;
    self.parameters = nil;
    self.previousPageNumber = nil;
    self.startRecordIndex = nil;
    self.totalRecord = nil;
    self.url = nil;
}

- (id)initWithJSON:(id)jsonObj
{
    if (self = [super init])
    {
//        self.curPage = [jsonObj objectForKey:@"curPage"];
//        self.maxPageNumber = [jsonObj objectForKey:@"maxPageNumber"];
//        self.nextPageNumber = [jsonObj objectForKey:@"nextPageNumber"];
//        self.pageRecord = [jsonObj objectForKey:@"pageRecord"];
//        self.paginate = [jsonObj objectForKey:@"paginate"];
//        self.parameters = [jsonObj objectForKey:@"parameters"];
//        self.previousPageNumber = [jsonObj objectForKey:@"previousPageNumber"];
//        self.startRecordIndex = [jsonObj objectForKey:@"startRecordIndex"];
//        self.totalRecord = [jsonObj objectForKey:@"totalRecord"];
//        self.url = [jsonObj objectForKey:@"url"];
        
        [self setValuesForKeysWithDictionary:jsonObj];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.curPage = [aDecoder decodeObjectForKey:@"curPage"];
        self.maxPageNumber = [aDecoder decodeObjectForKey:@"maxPageNumber"];
        self.nextPageNumber = [aDecoder decodeObjectForKey:@"nextPageNumber"];
        self.pageRecord = [aDecoder decodeObjectForKey:@"pageRecord"];
        self.paginate = [aDecoder decodeObjectForKey:@"paginate"];
        self.parameters = [aDecoder decodeObjectForKey:@"parameters"];
        self.previousPageNumber = [aDecoder decodeObjectForKey:@"previousPageNumber"];
        self.startRecordIndex = [aDecoder decodeObjectForKey:@"startRecordIndex"];
        self.totalRecord = [aDecoder decodeObjectForKey:@"totalRecord"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.curPage forKey:@"curPage"];
    [aCoder encodeObject:self.maxPageNumber forKey:@"maxPageNumber"];
    [aCoder encodeObject:self.nextPageNumber forKey:@"nextPageNumber"];
    [aCoder encodeObject:self.pageRecord forKey:@"pageRecord"];
    [aCoder encodeObject:self.paginate forKey:@"paginate"];
    [aCoder encodeObject:self.parameters forKey:@"parameters"];
    [aCoder encodeObject:self.previousPageNumber forKey:@"previousPageNumber"];
    [aCoder encodeObject:self.startRecordIndex forKey:@"startRecordIndex"];
    [aCoder encodeObject:self.totalRecord forKey:@"totalRecord"];
    [aCoder encodeObject:self.url forKey:@"url"];
}

- (id)copyWithZone:(NSZone *)zone
{
    QFPKHTTPResponseResultBean *bean = [[QFPKHTTPResponseResultBean alloc] init];
    bean.curPage = self.curPage;
    bean.maxPageNumber = self.maxPageNumber;
    bean.nextPageNumber = self.nextPageNumber;
    bean.pageRecord = self.pageRecord;
    bean.paginate = self.paginate;
    bean.parameters = [self.parameters copy];
    bean.previousPageNumber = self.previousPageNumber;
    bean.startRecordIndex = self.startRecordIndex;
    bean.totalRecord = self.totalRecord;
    bean.url = self.url;
    
    return nil;
}

- (NSString *)description
{
    return ObjcDescription(self);
}

@end

@implementation QFPKHTTPResponseResult

- (void)dealloc
{
    self.status = nil;
    self.message = nil;
    self.bean = nil;
    self.data = nil;
}

- (id)initWithJSON:(id)jsonObj
{
    if (self = [super init])
    {
        self.status = [jsonObj objectForKey:@"status"];
        self.message = [jsonObj objectForKey:@"message"];
        self.data = [jsonObj objectForKey:@"data"];
        
        id beanObj = [jsonObj objectForKey:@"bean"];
        self.bean = [[QFPKHTTPResponseResultBean alloc] initWithJSON:beanObj];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
        self.bean = [aDecoder decodeObjectForKey:@"bean"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.status forKey:@"message"];
    [aCoder encodeObject:self.status forKey:@"data"];
    [aCoder encodeObject:self.status forKey:@"bean"];
}

- (id)copyWithZone:(NSZone *)zone
{
    QFPKHTTPResponseResult *result = [[QFPKHTTPResponseResult alloc] init];
    result.status = self.status;
    result.message = self.message;
    result.data = [self.data copy];
    result.bean = [self.bean copy];
    
    return result;
}

- (NSString *)description
{
    return ObjcDescription(self);
}

@end
