//
//  QFSearchResultViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/5/21.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFSearchResultViewController.h"
#import "GlobalDefine.h"
#import "QFSearchResultCell.h"
#import "QFVegetablePrototype.h"
#import "QFFloatingHeaderViewLayout.h"
#import "QFSearchResultHeaderView.h"
#import "QFVegetablesVideoDetailViewController.h"


#define kSearchResultCell @"kSearchResultCell"
#define kSearchResultHeader @"kSearchResultHeader"


@interface QFSearchResultViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation QFSearchResultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Helper Methods


- (void)setupUI
{
    self.title = @"搜索结果";
    UIBarButtonItem *backBBI = [QFPKUIFactory createBackBBIWithTarget:self action:@selector(backBBIDidClicked:)];
    UIBarButtonItem *spaceBBI = [QFPKUIFactory createSpaceBBIWithWidth:-10];
    self.navigationItem.leftBarButtonItems = @[spaceBBI, backBBI];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"QFSearchResultCell" bundle:nil] forCellWithReuseIdentifier:kSearchResultCell];
    [_collectionView registerNib:[UINib nibWithNibName:@"QFSearchResultHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSearchResultHeader];
    
    _collectionView.backgroundColor = [QFPKUIFactory createVCBackgroundColor];
}

- (NSString *)paramCombination
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    NSArray *keys = @[@"child_catalog_name", @"fitting_crowd", @"taste", @"cooking_method", @"effect", @"name"];
    for (NSString *key in keys) {
        NSString *value = _searchParams[key];
        if (value && value.length>0) {
            [tempArr addObject:value];
        }
    }
    
    if (tempArr.count > 0) {
        return [tempArr componentsJoinedByString:@", "];
    }
    else {
        return nil;
    }
}


#pragma mark - Event Handlers


- (void)backBBIDidClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UICollectionViewDataSource

// Item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _resultData.count;
}

// Section的内容边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

// Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (SCREEN_WIDTH-30)/2.0;
    CGFloat itemHeight = itemWidth * 0.618 + 21;
    return CGSizeMake(itemWidth, itemHeight);
}

// 显示Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QFSearchResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSearchResultCell forIndexPath:indexPath];
    
    QFVegetablePrototype *vegetable = _resultData[indexPath.row];
    
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:vegetable.imagePathThumbnails]];
    cell.titleLabel.text = vegetable.name;
    
    return cell;
}

// SectionHeader的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([self paramCombination]) {
        return CGSizeMake(0, 46);
    }
    else {
        return CGSizeZero;
    }
}

// Section Header 的显示
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    QFSearchResultHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSearchResultHeader forIndexPath:indexPath];

    if ([self paramCombination]) {
        headerView.titleLabel.text = [NSString stringWithFormat:@"搜索组合：%@", [self paramCombination]];
    }
    else {
        headerView.titleLabel.text = @"";
    }
    
    return headerView;
}

// 选中Cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QFVegetablePrototype *v = [_resultData objectAtIndex:indexPath.row];
    QFVegetablesVideoDetailViewController *videoVC = [[QFVegetablesVideoDetailViewController alloc] initWithNibName:@"QFVegetablesVideoDetailViewController" bundle:nil];
    videoVC.vegetable = v;
    
    [self.navigationController pushViewController:videoVC animated:YES];
}


@end
