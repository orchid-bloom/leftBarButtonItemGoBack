//
//  QFVegetableVideoDetailCommentsView.m
//  PocketKitchen
//
//  Created by Tema on 15/5/23.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetableVideoDetailCommentsView.h"
#import "GlobalDefine.h"
#import "QFVegetableComment.h"
#import "QFVegetableVideoDetailHeader.h"
#import "QFVegetableDetailCommentCell.h"


#define kCommentsViewCell @"kCommentsViewCell"
#define kCommentsViewMoreCell @"kCommentsViewMoreCell"
#define kCommentsViewHeader @"kCommentsViewHeader"


@implementation QFVegetableVideoDetailCommentsView


#pragma mark - Initialization Methods


+ (instancetype)commentsView
{
    QFVegetableVideoDetailCommentsView *view = [[[NSBundle mainBundle] loadNibNamed:@"QFVegetableVideoDetailCommentsView" owner:nil options:nil] lastObject];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 244);
    view.tableView.dataSource = view;
    view.tableView.delegate = view;
    
    return view;
}

- (void)awakeFromNib
{
    [self setupUI];
    
    _dataSource = [[NSMutableArray alloc] init];
}


#pragma mark - Interface Methods


- (void)refreshWithData:(id)commentsData
{
    [_dataSource removeAllObjects];
    
    for (id data in commentsData) {
        [_dataSource addObject:[QFVegetableComment commentWithData:data]];
    }
    
    [_tableView reloadData];
}


#pragma mark - Helper Methods


- (void)setupUI
{
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCommentsViewMoreCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QFVegetableDetailCommentCell" bundle:nil] forCellReuseIdentifier:kCommentsViewCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QFVegetableVideoDetailHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:kCommentsViewHeader];
    
    UIView *zeroView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.tableFooterView = zeroView;
}


#pragma mark - UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= _dataSource.count) {
        return 40;
    }
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QFVegetableVideoDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kCommentsViewHeader];
    header.backgroundImageView.image = [UIImage imageNamed:@"detail_comment_header"];
    header.titleLabel.text = @"相关评论";
    header.titleLabel.textColor = [QFPKUIFactory createThemeColor];
    
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= _dataSource.count) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentsViewMoreCell forIndexPath:indexPath];
        cell.textLabel.text = @"查看更多评论";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor blueColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    else {
        
        QFVegetableDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentsViewCell forIndexPath:indexPath];
        QFVegetableComment *comment = _dataSource[indexPath.row];
        [cell.headPortraitImageView sd_setImageWithURL:[NSURL URLWithString:comment.userImage]];
        cell.titleLabel.text = comment.username;
        cell.dateLabel.text = comment.commentTime;
        cell.contentLabel.text = comment.commentContent;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= _dataSource.count) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
    }
}

@end
