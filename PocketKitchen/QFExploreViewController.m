//
//  QFExploreViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFExploreViewController.h"
#import "QFExploreTableViewCell.h"
#import "QFSimpleListCell.h"
#import "GlobalDefine.h"

@class QFExploreItem;

#define ExploreCellReuseID @"ExploreCell"


/**
 发现界面
 */
@interface QFExploreViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (nonatomic, retain) NSArray               *items;

@end

@implementation QFExploreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self initItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods


/**
 设置UI
 */
- (void)setupUI
{
    [_tableView registerNib:[UINib nibWithNibName:@"QFSimpleListCell" bundle:nil] forCellReuseIdentifier:ExploreCellReuseID];
}


/**
 初始化要显示的数据
 */
- (void)initItems
{
    self.items = @[
  @[[QFSimpleListItem itemWithTitle:@"食材大全" icon:@"expl_food" type:0],
    [QFSimpleListItem itemWithTitle:@"家电厨具佳肴" icon:@"expl_household" type:1],
    [QFSimpleListItem itemWithTitle:@"卖汤汤" icon:@"expl_soup" type:2]],
  
  @[[QFSimpleListItem itemWithTitle:@"摇一摇" icon:@"expl_shake" type:3],
    [QFSimpleListItem itemWithTitle:@"扫一扫" icon:@"expl_scan" type:4]],
  
  @[[QFSimpleListItem itemWithTitle:@"新书推荐" icon:@"expl_newbook" type:5],
    [QFSimpleListItem itemWithTitle:@"发现搜索" icon:@"expl_found" type:6]]
  ];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.items objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFSimpleListCell *cell = [tableView dequeueReusableCellWithIdentifier:ExploreCellReuseID forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    QFSimpleListItem *item = [[self.items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.titleLabel.text = item.title;
    cell.iconImageView.image = [UIImage imageNamed:item.iconName];

    if (item.type == 2) {
        cell.hotIcon.hidden = NO;
    }
    else {
        cell.hotIcon.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


#pragma mark - QFSimpleListItem


@implementation QFSimpleListItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)iconName type:(NSInteger)type
{
    QFSimpleListItem *item = [[QFSimpleListItem alloc] init];
    item.title = title;
    item.iconName = iconName;
    item.type = type;
    
    return item;
}

@end
