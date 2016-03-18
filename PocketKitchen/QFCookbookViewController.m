//
//  QFCookbookViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFCookbookViewController.h"
#import "GlobalDefine.h"
#import "QFCookbookTableViewCell.h"
#import "QFSearchViewController.h"
#import "QFVegetable+CoreData.h"
#import "QFCookbookSection+CoreData.h"
#import "QFAdvertisement+CoreData.h"
#import "QFPKTabBarController.h"
#import "QFSearchIntellegenceViewController.h"
#import "QFVegetablePrototype.h"
#import "QFVegetablesVideoDetailViewController.h"


#define CookbookCellReuseID @"CookbookCell"

@interface QFCookbookViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain)   NSFetchedResultsController  *fetchedResultsController;

@property (nonatomic, retain)   UIScrollView    *adScrollView;
@property (nonatomic, retain)   UIPageControl   *adPageControl;

@property (nonatomic, assign)   NSInteger       advertisementsCount;
@property (nonatomic, assign)   BOOL            stopTimer;

@end

@implementation QFCookbookViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self initFetchedResultsController];
    [self loadData];
    [self loadADData];
    [self startTheADTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods


/**
 页面初始的UI设置
 */
- (void)setupUI
{
    // 导航搜索按钮
    UIBarButtonItem *searchBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBBIClick:)];
    searchBBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = searchBBI;
    
    // TableView
    [self.tableView registerNib:[UINib nibWithNibName:@"QFCookbookTableViewCell" bundle:nil] forCellReuseIdentifier:CookbookCellReuseID];
    
    // 滚动广告页
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 190)];
    self.adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, headerView.bounds.size.width-20, headerView.bounds.size.height-5)];
    _adScrollView.pagingEnabled = YES;
    _adScrollView.delegate = self;
    [headerView addSubview:_adScrollView];
    
    self.adPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, 30)];
    _adPageControl.center = CGPointMake(headerView.center.x, 170);
    _adPageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [headerView addSubview:_adPageControl];
    
    [_adPageControl addTarget:self action:@selector(pageControlDidChanged:) forControlEvents:UIControlEventValueChanged];

    self.tableView.tableHeaderView = headerView;
}


/**
 初始化FetchedResultsController
 */
- (void)initFetchedResultsController
{
    // 生成一个获取请求
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CD_ENTITY_NAME_COOKBOOKSECTION];
    fetchRequest.predicate = nil;
    
    // 设置排序，这里不能用Block的SortDescriptor
    NSSortDescriptor *sortDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"sortNumber"
                                  ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    // 生成FetchedResultsController
    NSManagedObjectContext *context = [[[QFCoreDataDocumentManager manager] managedDocument] managedObjectContext];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"SectionCache"];
    
    self.fetchedResultsController.delegate = self;
}


/**
 加载TableView显示的数据
 */
- (void)loadData
{
    // 不管有网没网，先加载本地数据
    [self getLocaledData];
    
    // 加载网络数据，如果没有网，就提示网络错误
    [self downloadNetworkData];
    
    
    //    // 用AFNetworking来判断网络是否可用，如果有网，就去下载
    //    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //
    //        if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
    //            [self downloadNetworkData];
    //        }
    //    }];
    //
    //    [manager startMonitoring];
}


/**
 加载滚动广告数据
 */
- (void)loadADData
{
    // 先加载本地数据，先让他显示出来
    [self getADLocaledData];
    
    NSDictionary *params = @{@"is_traditional": @"0",
                             @"phonetype": @"1"};
    
    // 从网络上加载
    [AFHTTPRequestOperationManager GETRequest:URL_COOKBOOK_AD parameters:params success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {
        
        NSManagedObjectContext *context = [[[QFCoreDataDocumentManager manager] managedDocument] managedObjectContext];
        for (id obj in result.data) {
            
            [QFAdvertisement advertisementWithData:obj inManagedObjectContext:context];
        }
        
        [self getADLocaledData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load ad data error: %@", error);
    }];
}


/**
 下载菜谱这个页面的数据
 */
- (void)downloadNetworkData
{
    // 显示HUD
//    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleLight];
//    hud.textLabel.text = @"正在加载数据...";
//    [hud showInView:self.navigationController.view];
    
    NSDictionary *params = @{@"user_id": @"0",
                             @"is_traditional": @"0",
                             @"page": @"1",
                             @"pageRecord": @"3",
                             @"phonetype": @"1"};
    
    // 下载数据
    [AFHTTPRequestOperationManager GETRequest:URL_COOKBOOK parameters:params success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {
        
        // 隐藏HUD
//        [hud dismissAnimated:YES];
        
        // 先把下载的数据保存到数据库
        UIManagedDocument *document = [[QFCoreDataDocumentManager manager] managedDocument];
        for (int i=0; i<[result.data count]; i++) {
            id obj = [result.data objectAtIndex:i];
            
            QFCookbookSection *section = [QFCookbookSection sectionItemWithData:obj inManagedObjectContext:document.managedObjectContext];
            section.sortNumber = [NSString stringWithFormat:@"%d", i+1];
        }
        
        // 再从数据库取出数据展示
        [self getLocaledData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 隐藏HUD
//        [hud dismissAnimated:YES];
        
        [QFErrorHandler handleError:error];
    }];
}


/**
 加载本地数据
 */
- (void)getLocaledData
{
    NSError *error = nil;
    if ([self.fetchedResultsController performFetch:&error]) {
        [_tableView reloadData];
    }
    else {
        [QFErrorHandler handleError:error];
    }
}


/**
 加载广告页的本地数据
 */
- (void)getADLocaledData
{
    NSManagedObjectContext *context = [[[QFCoreDataDocumentManager manager] managedDocument] managedObjectContext];
    NSArray *advertisements = [QFAdvertisement allAdvertisementsInManagedObjectContext:context];
    self.advertisementsCount = advertisements.count;
    
    // 移除掉原来的ImageView
    NSArray *scvSubViews = _adScrollView.subviews;
    for (UIView *subView in scvSubViews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGSize scvSize = _adScrollView.bounds.size;
    for (int i=0; i<advertisements.count; i++) {
        // 创建ImageView
        QFAdvertisement *advertisement = advertisements[i];
        
        QFTouchImageView *imageView = [[QFTouchImageView alloc] initWithFrame:CGRectMake(i*scvSize.width, 0, scvSize.width, scvSize.height)];
        [_adScrollView addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:advertisement.imageFilename]];

        imageView.userInfo = advertisement;
        [imageView setTarget:self action:@selector(adImageViewDidClicked:)];
    }
    _adScrollView.contentSize = CGSizeMake(scvSize.width*advertisements.count, scvSize.height);
    _adPageControl.numberOfPages = advertisements.count;
}


/**
 启动广告滚动的定时器
 */
- (void)startTheADTimer
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), 3 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (_advertisementsCount) {
            _adPageControl.currentPage = (_adPageControl.currentPage+1)%_advertisementsCount;
            [self pageControlDidChanged:_adPageControl];
        }
        
        if (_stopTimer) {
            dispatch_source_cancel(timer);
        }
    });
    dispatch_resume(timer);
}


#pragma mark - Event Handlers


/**
 搜索按钮的点击处理
 */
- (void)searchBBIClick:(UIBarButtonItem *)bbiClick
{
    // 点击搜索按钮，跳到搜索页面
    QFSearchViewController *searchVC = [[QFSearchViewController alloc] initWithNibName:@"QFSearchViewController" bundle:nil];
    searchVC.tabBarItem.image = [UIImage imageNamed:@"search_category"];
    searchVC.tabBarItem.selectedImage = [UIImage imageNamed:@"search_category_hl"];
    searchVC.title = @"分类搜索";
    
    QFSearchIntellegenceViewController *intellgenceVC = [[QFSearchIntellegenceViewController alloc] initWithNibName:@"QFSearchIntellegenceViewController" bundle:nil];
    intellgenceVC.tabBarItem.image = [UIImage imageNamed:@"search_intellegence"];
    intellgenceVC.tabBarItem.selectedImage = [UIImage imageNamed:@"search_intellegence_hl"];
    intellgenceVC.title = @"智能选菜";
    
    QFPKTabBarController *searchTab = [[QFPKTabBarController alloc] init];
    searchTab.viewControllers = @[searchVC, intellgenceVC];
    searchTab.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchTab animated:YES];
}

/**
 cell上的显示更多按钮的点击处理
 */
- (void)viewMoreBtnDidClick:(UIButton *)btn
{
    NSLog(@"btn.tag = %ld", (long)btn.tag);
}

/**
 广告图片点击事件处理
 */
- (void)adImageViewDidClicked:(QFTouchImageView *)imageView
{
    NSLog(@"%@", imageView.userInfo);
}

/**
 菜谱视频点击事件处理
 */
- (void)vegetableVideoClicked:(QFTouchImageView *)imageView
{
    QFVegetablePrototype *vegetable = [QFVegetablePrototype vegetableFrom:imageView.userInfo];
    QFVegetablesVideoDetailViewController *videoDetailVC = [QFVegetablesVideoDetailViewController instanceWithDefaultNib];
    videoDetailVC.vegetable = vegetable;
    videoDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoDetailVC animated:YES];
}

/**
 pageControl点击，index改变
 */
- (void)pageControlDidChanged:(UIPageControl *)pageControl
{
    [_adScrollView setContentOffset:CGPointMake(pageControl.currentPage * _adScrollView.bounds.size.width, _adScrollView.contentOffset.y) animated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFCookbookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CookbookCellReuseID forIndexPath:indexPath];
    
    if (self.fetchedResultsController.fetchedObjects.count > 0) {
        
        // 取到数据模型
        QFCookbookSection *section = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // 根据数据模型来显示cell
        cell.sectionTitle.text = section.name;
        [cell.sectionIcon sd_setImageWithURL:[NSURL URLWithString:section.imageFilename]];
        
        [cell.viewMoreBtn setTag:[section.type integerValue] + 100];
        [cell.viewMoreBtn addTarget:self action:@selector(viewMoreBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *titles = @[cell.videoTitle0, cell.videoTitle1, cell.videoTitle2];
        NSArray *videos = @[cell.sectionVideo0, cell.sectionVideo1, cell.sectionVideo2];
        for (int i=0; (i<section.vegetables.count && i<3); i++) {
            
            QFVegetable *vegetable = section.vegetables[i];
            
            // 设置视频标题
            UILabel *titleLabel = titles[i];
            titleLabel.text = vegetable.name;
            
            QFTouchImageView *videoImageView = videos[i];
            
            // 设置视频的封面图片
            [videoImageView sd_setImageWithURL:[NSURL URLWithString:vegetable.imagePathThumbnails]];
            
            // 设置视频点击事件
            videoImageView.userInfo = vegetable;
            [videoImageView setTarget:self action:@selector(vegetableVideoClicked:)];
        }
        
        // 设置是否显示播放图标
        if ([section.type isEqualToString:@"5"]) {
            cell.videoPlayIcon0.hidden = YES;
            cell.videoPlayIcon1.hidden = YES;
            cell.videoPlayIcon2.hidden = YES;
        }
        else {
            cell.videoPlayIcon0.hidden = NO;
            cell.videoPlayIcon1.hidden = NO;
            cell.videoPlayIcon2.hidden = NO;
        }
        
        if (indexPath.section==0 && indexPath.row == 0) {
            cell.hotIcon.hidden = NO;
        }
        else {
            cell.hotIcon.hidden = YES;
        }
    }
    
    return cell;
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _adPageControl.currentPage = index;
}


@end
