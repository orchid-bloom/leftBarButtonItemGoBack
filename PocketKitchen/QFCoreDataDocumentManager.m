//
//  QFCoreDataDocumentManager.m
//  PocketKitchen
//
//  Created by Tema on 15/3/17.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFCoreDataDocumentManager.h"
#import "GlobalDefine.h"

@implementation QFCoreDataDocumentManager


#pragma mark - Initialization Methods

// 单例的实现
+ (instancetype)manager
{
    static QFCoreDataDocumentManager    *manager;
    static dispatch_once_t              onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        NSString *storeFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:CD_STORE_FILE_NAME];
        
        NSLog(@"Databace Store File Path: %@", storeFilePath);
        
        NSURL    *storeFileURL = [NSURL fileURLWithPath:storeFilePath];
         
        _managedDocument = [[UIManagedDocument alloc] initWithFileURL:storeFileURL];
        
        // 如果sqlite文件存在，就打开文件
        if ([[NSFileManager defaultManager] fileExistsAtPath:storeFilePath]) {
            [_managedDocument openWithCompletionHandler:^(BOOL success) {
                
                if (success) {
                    // document打开成功
                    _documentStatus = QFCoreDataDocumentOpenSucceed;
                }
                else {
                    
                    // document打开失败
                    NSError *error = [NSError errorWithDomain:ERROR_DOMAIN_COREDATA
                                                         code:ERROR_CODE_COREDATA_OPENFAILED
                                                     userInfo:@{ NSLocalizedDescriptionKey: @"数据库打开失败" }];
                    [QFErrorHandler handleError:error];
                    _documentStatus = QFCoreDataDocumentOpenFailed;
                }
            }];
        }
        else {  // 如果文件不存在，就保存创建文件
            [_managedDocument saveToURL:storeFileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                if (success) {
                    // 文件创建成功
                    _documentStatus = QFCoreDataDocumentOpenSucceed;
                }
                else {
                    NSError *error = [NSError errorWithDomain:ERROR_DOMAIN_COREDATA
                                                         code:ERROR_CODE_COREDATA_CREATEFAILED
                                                     userInfo:@{ NSLocalizedDescriptionKey: @"数据库文件创建失败"}];
                    [QFErrorHandler handleError:error];
                    _documentStatus = QFCoreDataDocumentCreateFailed;
                }
            }];
        }
    }
    
    return self;
}


#pragma mark - Setter & Getter


- (UIManagedDocument *)managedDocument
{
    return _managedDocument;
}

- (QFCoreDataDocumentManagerStatus)documentStatus
{
    return _documentStatus;
}

@end
