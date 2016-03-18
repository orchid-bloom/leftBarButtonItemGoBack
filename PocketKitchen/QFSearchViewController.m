//
//  QFSearchViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFSearchViewController.h"
#import "GlobalDefine.h"
#import "QFSearchHeaderView.h"
#import "QFSearchSectionView.h"
#import "QFSearchCategoryCell.h"
#import "QFSearchCategoryCollectionCell.h"
#import "QFSearchCategoryItem.h"
#import "QFSearchSelectedItemView.h"
#import "AFHTTPRequestOperationManager+QFPKRequest.h"
#import "QFVegetablePrototype.h"
#import "QFSearchResultViewController.h"


/**
 "搜索"页面
 */
@interface QFSearchViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, QFSearchSelectedItemViewDelegate>

@property (weak, nonatomic)     IBOutlet    UITableView         *tableView;
@property (weak, nonatomic)     IBOutlet    UITextField         *searchTextField;
@property (weak, nonatomic)     IBOutlet    UIImageView         *searchBGImageView;
@property (weak, nonatomic)     IBOutlet    NSLayoutConstraint  *inputViewBottomConstraint;

@property (nonatomic, strong)               NSMutableDictionary *sectionViews;
@property (nonatomic, strong)               NSArray             *sectionDataKeys;
@property (nonatomic, assign)               NSInteger           seletedSectionIndex;
@property (nonatomic, assign)               CGFloat             collectionItemWidth;
@property (nonatomic, strong)               NSMutableDictionary *sectionSelectedItems;
@property (nonatomic, strong)               NSDictionary        *sectionData;
@property (nonatomic, strong)               QFSearchHeaderView  *headerView;

@end

@implementation QFSearchViewController


- (void)dealloc
{
    // 移除键盘升起和降落的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.title = @"分类搜索";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupUI];
    
    self.seletedSectionIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Setter & Getter


- (void)setSeletedSectionIndex:(NSInteger)seletedSectionIndex
{
    if (_seletedSectionIndex != seletedSectionIndex) {
        
        NSString *oldKey = [NSString stringWithFormat:@"%ld", _seletedSectionIndex + 100];
        QFSearchSectionView *oldSectionView = [_sectionViews objectForKey:oldKey];
        oldSectionView.sectionBGImageView.image = [UIImage imageNamed:@"search_section_bg"];
        oldSectionView.titleLabel.textColor = [UIColor darkGrayColor];
        
        NSString *newKey = [NSString stringWithFormat:@"%ld", seletedSectionIndex + 100];
        QFSearchSectionView *newSectionView = [_sectionViews objectForKey:newKey];
        newSectionView.sectionBGImageView.image = [UIImage imageNamed:@"search_section_bg_hl"];
        newSectionView.titleLabel.textColor = [QFPKUIFactory createThemeColor];
        
        _seletedSectionIndex = seletedSectionIndex;
        
        [_tableView reloadData];
    }
}


#pragma mark - Helper Methods


/**
 初始化必要数据
 */
- (void)initData
{
    _sectionViews = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    _sectionSelectedItems = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"SearchCategorys" ofType:@"plist"];
    _sectionData = [[NSDictionary alloc] initWithContentsOfFile:dataFilePath];
    
    _sectionDataKeys = [_sectionData objectForKey:@"order_titles"];
}

/**
 设置UI
 */
- (void)setupUI
{
    // 设置返回按钮
    UIBarButtonItem *backBBI = [QFPKUIFactory createBackBBIWithTarget:self action:@selector(backBBIClicked:)];
    
    // 调整BBI的位置
    UIBarButtonItem *spaceBBI = [QFPKUIFactory createSpaceBBIWithWidth:-10];
    
    // 注意这里的层级关系
    self.tabBarController.navigationItem.leftBarButtonItems = @[spaceBBI, backBBI];
    
    // 设置背景颜色
    self.view.backgroundColor = [QFPKUIFactory createVCBackgroundColor];

    // TableView
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QFSearchCategoryCell" bundle:nil] forCellReuseIdentifier:@"SearchCategoryCell"];
    
    self.tableView.tableHeaderView = [self createHearderViewWithConstraints];

    // 为了移除Table最底下的线
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footerView;
    
    UIImage *image = [UIImage imageNamed:@"search_inputview"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 50, 0, 50)];
    self.searchBGImageView.image = image;
    
    // 计算Collection Items的宽度
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.collectionItemWidth = (screenSize.width - 40 - 15) / 4.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


/**
 生成headerView
 
 @return 返回创建好的headerView
 */
- (UIView *)createHearderViewWithConstraints
{
    // tableView Header
    
    // 从xib加实例化一个view
    UINib *headerViewNib = [UINib nibWithNibName:@"QFSearchHeaderView" bundle:nil];
    _headerView = [[headerViewNib instantiateWithOwner:nil options:nil] lastObject];
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 用一个背景的View来确定headerView的高度
    UIView *headerViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 120)];
    [headerViewBg addSubview:_headerView];
    
    // 添加headerView的Constraint
    NSDictionary *views = NSDictionaryOfVariableBindings(_headerView);
    NSArray *hConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headerView]|"
                                            options:0
                                            metrics:nil
                                              views:views];
    NSArray *vConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headerView]|"
                                            options:0
                                            metrics:nil
                                              views:views];
    
    [headerViewBg addConstraints:hConstraints];
    [headerViewBg addConstraints:vConstraints];
    
    return headerViewBg;
}

- (void)addHeaderItemViewWithUserInfo:(id)userInfo
{
    // 判断这个section的ItemView是不是已经存在，存在就改变他的title和userInfo
    // 如果不存在，就添加一个新的ItemView
    NSString    *title = [[userInfo objectForKey:@"data"] objectForKey:@"name"];
    BOOL        alreadyExists = NO;
    
    for (QFSearchSelectedItemView *itemView in _headerView.contentView.subviews) {
        
        if ([[itemView.userInfo objectForKey:@"section"] isEqualToString:[userInfo objectForKey:@"section"]]) {
            [itemView setTitle:title userInfo:userInfo];
            
            alreadyExists = YES;
            break;
        }
    }
    
    if (alreadyExists == NO) {
        CGFloat itemWidth = (_headerView.contentView.bounds.size.width-40) / 3.0f;
        CGFloat itemHeight = (_headerView.contentView.bounds.size.height-30) / 2.0f;
        NSInteger itemCount = _headerView.contentView.subviews.count;
        
        QFSearchSelectedItemView *itemView =
        [[QFSearchSelectedItemView alloc] initWithFrame:CGRectMake((itemWidth+10)*(itemCount%3)+10, (itemHeight+10)*(itemCount/3)+10, itemWidth, itemHeight)
                                                  title:title
                                               delegate:self
                                               userInfo:userInfo];
        [_headerView.contentView addSubview:itemView];
    }
}

/**
 从服务器查询数据
 */
- (void)searchDataFromNetwork
{
    // 获取参数
    NSString *name = EMPTY_STRING([self.searchTextField.text trimBlank]);
    NSString *child_catalog_name = EMPTY_STRING(_sectionSelectedItems[@"child_catalog_name"][@"name"]);
    NSString *fitting_crowd = EMPTY_STRING(_sectionSelectedItems[@"fitting_crowd"][@"name"]);
    NSString *cooking_method = EMPTY_STRING(_sectionSelectedItems[@"cooking_method"][@"name"]);
    NSString *effect = EMPTY_STRING(_sectionSelectedItems[@"effect"][@"name"]);
    NSString *taste = EMPTY_STRING(_sectionSelectedItems[@"taste"][@"name"]);
    
    child_catalog_name = [child_catalog_name stringByAppendingString:@"菜"];
    
    NSDictionary *params = @{@"name": name,
                             @"child_catalog_name": child_catalog_name,
                             @"fitting_crowd": fitting_crowd,
                             @"cooking_method": cooking_method,
                             @"effect": effect,
                             @"taste": taste,
                             @"page": @"1",
                             @"pageRecord": @"10",
                             @"phonetype": @"0",
                             @"user_id": @"",
                             @"is_traditional": @"0"};
    
    // 显示一个HUD
    JGProgressHUD *hud = [JGProgressHUD showSimpleHUDWithText:@"正在搜索中..."
                                                       inView:self.navigationController.view];
    
    // 去请求网络
    NSLog(@"%@",params);
    [AFHTTPRequestOperationManager GETRequest:URL_VEGETABLE_INFO parameters:params success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {
        
        // 请求完成隐藏HUD
        [hud hides];
        
        // 如果数据不对，就显示服务器返回的提示信息
        if (![result.status isEqualToString:@"0"]) {
            [DPRemind simpleRemindMessage:result.message];
        }
        else {
            
            // 如果数据正确，就解析数据
            if ([result.data count] == 0) {
                [DPRemind simpleRemindMessage:@"搜索不到对应条件的菜谱"];
            }
            else {
                NSMutableArray *resultData = [[NSMutableArray alloc] initWithCapacity:[result.data count]];
                for (id data in result.data) {
                    QFVegetablePrototype *vegetable = [QFVegetablePrototype vegetableWithData:data];
                    [resultData addObject:vegetable];
                }
                
                // 跳到搜索结果界面
                QFSearchResultViewController *resultVC = [[QFSearchResultViewController alloc] initWithNibName:@"QFSearchResultViewController" bundle:nil];
                resultVC.searchParams = params;
                resultVC.resultData = [NSMutableArray arrayWithArray:resultData];
                [self.navigationController pushViewController:resultVC animated:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 请求完成隐藏HUD
        [hud hides];
        [DPRemind simpleRemindMessage:@"网络错误，请检查网络设置"];
        
        NSLog(@"%@", error);
    }];

}


#pragma mark - Event Handlers


/**
 返回按钮的点击事件
 */
- (void)backBBIClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 section的点击事件处理
 */
- (void)sectionDidClicked:(UITapGestureRecognizer *)tap
{
    self.seletedSectionIndex = tap.view.tag - 100;
    
    [self.searchTextField resignFirstResponder];
}


/**
 搜索按钮的点击处理
 */
- (IBAction)searchBtnDidClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 没有任务搜索条件
    if (_sectionSelectedItems.count==0 && [self.searchTextField.text trimBlank].length==0) {
        [DPRemind simpleRemindMessage:@"请确认搜索条件"];
        return;
    }
    
    [self searchDataFromNetwork];
}


#pragma mark - Notification Handlers


/**
 键盘升起
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    float animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.inputViewBottomConstraint.constant = keyboardHeight;
        [self.view layoutIfNeeded];
    } completion:nil];
}


/**
 键盘隐藏
 */
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.inputViewBottomConstraint.constant = 49;
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionDataKeys.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%ld", section+100];
    QFSearchSectionView *sectionView = [_sectionViews objectForKey:key];
    
    // 创建tableView section header
    if (sectionView == nil) {
        
        sectionView = [[[UINib nibWithNibName:@"QFSearchSectionView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionDidClicked:)];
        sectionView.tag = 100+section;
        NSString *key = _sectionDataKeys[section];
        sectionView.titleLabel.text = [[_sectionData objectForKey:key] objectForKey:@"title"];
        [sectionView addGestureRecognizer:tap];
        
        [_sectionViews setObject:sectionView forKey:key];
    }
    
    // 判断是否是自己点的section
    if (section == self.seletedSectionIndex) {
        sectionView.sectionBGImageView.image = [UIImage imageNamed:@"search_section_bg_hl"];
        sectionView.titleLabel.textColor = [QFPKUIFactory createThemeColor];
    }
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.seletedSectionIndex == section)
        return 1;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionItemWidth + 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFSearchCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCategoryCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (cell.collectionView.dataSource==nil || cell.collectionView.delegate==nil) {
        cell.collectionView.backgroundColor = [UIColor clearColor];
        
        // 设置CollectionView的数据源和代理到这个ViewController
        cell.collectionView.dataSource = self;
        cell.collectionView.delegate = self;
        
        // 注册cell
        [cell.collectionView registerNib:[UINib nibWithNibName:@"QFSearchCategoryCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SearchCategoryCollectionCell"];
    }
    
    // 刷新CollectionView
    [cell.collectionView reloadData];
    
    // 让CollectionView滚到选中的Item那里
    NSString *sectionKey = _sectionDataKeys[_seletedSectionIndex];
    NSArray *dataArr = [[_sectionData objectForKey:sectionKey] objectForKey:@"data"];
    NSDictionary *dataItem = [_sectionSelectedItems objectForKey:sectionKey];
    
    if (dataItem) {
        NSInteger seletedIndex = [dataArr indexOfObject:dataItem];
        NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:seletedIndex inSection:0];
        [cell.collectionView scrollToItemAtIndexPath:itemIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    else {
        // 如果这个Section没有选中任何Item，就移动到最左边
        [cell.collectionView setContentOffset:CGPointZero animated:NO];
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *key = _sectionDataKeys[_seletedSectionIndex];
    return [[[_sectionData objectForKey:key] objectForKey:@"data"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QFSearchCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCategoryCollectionCell" forIndexPath:indexPath];
    
    // 取到对应数据和对应的下标
    NSString *sectionKey = _sectionDataKeys[_seletedSectionIndex];
    NSArray *dataArr = [[_sectionData objectForKey:sectionKey] objectForKey:@"data"];
    
    // 已经有被选择的Item
    NSDictionary *selectedDataItem = [_sectionSelectedItems objectForKey:sectionKey];
    NSInteger seletedIndex = [dataArr indexOfObject:selectedDataItem];
    
    if (selectedDataItem && indexPath.row == seletedIndex) {
        cell.bgImageView.image = [UIImage imageNamed:@"search_item_bg_hl"];
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.contentTitleLabel.textColor = [UIColor whiteColor];
    }
    else {
        cell.bgImageView.image = [UIImage imageNamed:@"search_item_bg"];
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        cell.contentTitleLabel.textColor = [UIColor lightGrayColor];
    }
    
    // 数据源
    NSDictionary *dataItem = [dataArr objectAtIndex:indexPath.row];

    // 判断有没有指定图片，有就显示contentImageView，没有就隐藏
    NSString *itemIconName = dataItem[@"iconName"];
    if (itemIconName && itemIconName.length > 0) {
        cell.contentImageView.hidden = NO;
        cell.contentTitleLabel.hidden = NO;
        cell.titleLabel.hidden = YES;
        
        cell.contentTitleLabel.text = dataItem[@"name"];
        
        // 选中就用高这图片，未选中就有普通图片
        if (selectedDataItem && indexPath.row == seletedIndex) {
            cell.contentImageView.image = [UIImage imageNamed:dataItem[@"hlIconName"]];
        }
        else {
            cell.contentImageView.image = [UIImage imageNamed:itemIconName];
        }
    }
    else {
        cell.contentImageView.hidden = YES;
        cell.contentTitleLabel.hidden = YES;
        cell.titleLabel.hidden = NO;
        cell.titleLabel.text = [dataItem objectForKey:@"name"];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionItemWidth, self.collectionItemWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击CollectionView的Item的时候，保存到选中的Item中
    NSString *sectionKey = _sectionDataKeys[_seletedSectionIndex];
    NSDictionary *dataItem = [[[_sectionData objectForKey:sectionKey] objectForKey:@"data"] objectAtIndex:indexPath.row];
    [_sectionSelectedItems setObject:dataItem forKey:sectionKey];
    [self addHeaderItemViewWithUserInfo:@{@"section": sectionKey, @"data": dataItem}];
    
    [collectionView reloadData];
}


#pragma mark - QFSearchSelectedItemViewDelegate


- (void)itemViewDidClickedRemoveButton:(QFSearchSelectedItemView *)itemView
{
    NSString *sectionKey = [itemView.userInfo objectForKey:@"section"];
    [_sectionSelectedItems removeObjectForKey:sectionKey];
    [itemView removeFromSuperview];
    
    if (_seletedSectionIndex == [_sectionDataKeys indexOfObject:sectionKey]) {
        [_tableView reloadData];
    }
    else {
        self.seletedSectionIndex = [_sectionDataKeys indexOfObject:sectionKey];
    }
    
    // 调整剩下的ItemView的位置    
    [UIView animateWithDuration:0.25 animations:^{
        for (int i=0; i<_headerView.contentView.subviews.count; i++) {
            
            CGFloat itemWidth = (_headerView.contentView.bounds.size.width-40) / 3.0f;
            CGFloat itemHeight = (_headerView.contentView.bounds.size.height-30) / 2.0f;
            
            QFSearchSelectedItemView *itemView = [_headerView.contentView.subviews objectAtIndex:i];
            itemView.frame = CGRectMake((itemWidth+10)*(i%3)+10, (itemHeight+10)*(i/3)+10, itemWidth, itemHeight);
        }
    } completion:nil];
}


#pragma mark - Touched


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchTextField resignFirstResponder];
}

@end
