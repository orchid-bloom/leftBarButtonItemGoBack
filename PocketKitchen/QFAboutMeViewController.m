//
//  QFAboutMeViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFAboutMeViewController.h"
#import "QFExploreViewController.h"
#import "QFSimpleListCell.h"
#import "GlobalDefine.h"
#import "QFLoginViewController.h"


#define AboutMeCellReuseID @"AboutMeCell"


/**
 “我的”页面
 */
@interface QFAboutMeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray            *items;

@end

@implementation QFAboutMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initItems];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - Helper Methods


/**
 初始化UI设置
 */
- (void)setupUI
{
    // 登录按钮
    self.navigationItem.rightBarButtonItem = [QFPKUIFactory createTitleBBI:@"登录" target:self action:@selector(loginBBIDidClicked:)];
    
    // 注册要显示的cell
    [_tableView registerNib:[UINib nibWithNibName:@"QFSimpleListCell" bundle:nil] forCellReuseIdentifier:AboutMeCellReuseID];
}


/**
 初始化要显示的数据项
 */
- (void)initItems
{
    self.items = @[
                   @[[QFSimpleListItem itemWithTitle:@"我的信息" icon:@"me_info" type:0]],
                   
                   @[[QFSimpleListItem itemWithTitle:@"缓存视频" icon:@"me_videocache" type:1],
                     [QFSimpleListItem itemWithTitle:@"消息列表" icon:@"me_msg" type:2],
                     [QFSimpleListItem itemWithTitle:@"检查更新" icon:@"me_checkversion" type:3],
                     [QFSimpleListItem itemWithTitle:@"意见反馈" icon:@"me_feedback" type:4],
                     [QFSimpleListItem itemWithTitle:@"给我们评分" icon:@"me_grade" type:5],
                     [QFSimpleListItem itemWithTitle:@"关于我们" icon:@"me_about" type:6]]
                   ];
}


#pragma mark - Event Handlers


- (void)loginBBIDidClicked:(id)sender
{
    QFLoginViewController *loginVC = [[QFLoginViewController alloc] initWithNibName:@"QFLoginViewController" bundle:nil];
    loginVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:loginVC animated:YES];
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
    QFSimpleListCell *cell = [tableView dequeueReusableCellWithIdentifier:AboutMeCellReuseID forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    QFSimpleListItem *item = [[_items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.titleLabel.text = item.title;
    cell.iconImageView.image = [UIImage imageNamed:item.iconName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
