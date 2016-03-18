//
//  QFPlazaViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFPlazaViewController.h"
#import "QFPlazaCollectionViewCell.h"
#import "GlobalDefine.h"
#import "QFPlazaItems+CoreData.h"
#import "QFPlazaComments+CoreData.h"


#define PlazaCellReuseID @"PlazaCell"
#define PlazaCellWidth ((([[UIScreen mainScreen] bounds].size.width - 30) / 2.0f))


@interface QFPlazaViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSFetchRequest             *fetchRequest;

@end

@implementation QFPlazaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupFetchedResultsController];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods


/**
 初始化UI设置
 */
- (void)setupUI
{
    [_collectionView registerNib:[UINib nibWithNibName:@"QFPlazaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PlazaCellReuseID];
}


/**
 加载数据
 */
- (void)loadData
{
    [self loadLocalData];
    [self downloadNetworkData];
}

/**
 加载本地数据
 */
- (void)loadLocalData
{
    NSError *error = nil;
    if ([self.fetchedResultsController performFetch:&error]) {
        [_collectionView reloadData];
    }
    else {
        [QFErrorHandler handleError:error];
    }
}


/**
 下载网络数据
 */
- (void)downloadNetworkData
{
    NSDictionary *params = @{@"page": @"1",
                             @"pageRecord": @"30",
                             @"is_traditional": @"0"};
    
    [AFHTTPRequestOperationManager GETRequest:URL_PLAZA parameters:params success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {

        NSManagedObjectContext *context = [[[QFCoreDataDocumentManager manager] managedDocument] managedObjectContext];
        for (id itemData in result.data) {
            
            NSLog(@"%@", itemData);
            [QFPlazaItems plazaItemWithData:itemData inManagedObjectContext:context];
        }
        
        [self loadLocalData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [QFErrorHandler handleError:error];
    }];
}

/**
 配置 fetchedResultsController
 */
- (void)setupFetchedResultsController
{
    // 生成一个获取请求
    self.fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CD_ENTITY_NAME_PLAZAITEMS];
    _fetchRequest.predicate = nil;
    
    // 设置排序，这里不能用Block的SortDescriptor
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"auditDate" ascending:YES];
    _fetchRequest.sortDescriptors = @[sortDescriptor];
    
    // 设置查询数
    _fetchRequest.fetchLimit = 20;
    _fetchRequest.fetchOffset = 0;
    
    // 生成FetchedResultsController
    NSManagedObjectContext *context = [[[QFCoreDataDocumentManager manager] managedDocument] managedObjectContext];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:_fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"PlazaItemCache"];
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QFPlazaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PlazaCellReuseID forIndexPath:indexPath];
    
    QFPlazaItems *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.titleLabel.text = item.title;
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.userPortraitImageFileName]];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:item.imageFileName]];
    
    if (item.commentsArr.count > 0) {
        QFPlazaComments *comment = [item.commentsArr firstObject];
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@:%@", comment.userName, comment.content];
    }
    else {
        cell.descriptionLabel.text = @"快来评论吧！";
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 让cell的宽度自适合屏幕大小，高度不变
    return CGSizeMake(PlazaCellWidth, 177);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // 保持跟边框的距离
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
