//
//  QFVegetablesVideoDetailViewController.m
//  PocketKitchen
//
//  Created by Tema on 15/3/5.
//  Copyright (c) 2016年 Tema@gmail.com. All rights reserved.
//

#import "QFVegetablesVideoDetailViewController.h"
#import "GlobalDefine.h"
#import <MediaPlayer/MediaPlayer.h>
#import "QFVegetableVideoDetailHeader.h"
#import "QFVegetableVideoDetailCommentsView.h"
#import "QFVideoDetailMaterialTextCell.h"
#import "QFVideoDetailMaterialImageCell.h"
#import "QFVideoDetailStepCell.h"
#import "QFVideoDetailKnowledgeCell.h"


#define kVideoDetailCell @"kVideoDetailCell"
#define kVideoDetailTextCell @"kVideoDetailTextCell"
#define kVideoDetailImageCell @"kVideoDetailImageCell"
#define kVideoDetailStepCell @"kVideoDetailStepCell"
#define kVideoDetailKnowledgeCell @"kVideoDetailKnowledgeCell"
#define kVideoDetailHeader @"kVideoDetailHeader"


@interface QFVegetablesVideoDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *commentInputTextFiled;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playIcon;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *videoLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *commentLoadingIndicator;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playViewHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (nonatomic, strong) MPMoviePlayerController *videoPlayerController;

@property (nonatomic, strong) NSMutableDictionary   *dataSource;
@property (nonatomic, strong) NSArray               *dataSourceKeys;
@property (nonatomic, strong) NSMutableDictionary   *sectionHeaderDataSource;
@property (nonatomic, strong) NSMutableDictionary   *showSectionHeaderFlags;

@property (nonatomic, strong) QFVegetableVideoDetailCommentsView *commnetsView;

@end

@implementation QFVegetablesVideoDetailViewController


#pragma mark - Destructor


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


#pragma mark - Lifecycle Methods


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[QFPKUIFactory createThemeColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupUI];
    [self initVideoPlayer];
    [self loadDataFromNetwork];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Helper Methods


- (void)setupUI
{
    // 返回按钮
    UIBarButtonItem *backBBI = [QFPKUIFactory createBackBBIWithTarget:self action:@selector(backBBIDidClicked:)];
    UIBarButtonItem *spaceBBI = [QFPKUIFactory createSpaceBBIWithWidth:-10];
    self.navigationItem.leftBarButtonItems = @[spaceBBI, backBBI];
    
    self.title = _vegetable.name;
    self.view.backgroundColor = [QFPKUIFactory createVCBackgroundColor];
    
    // TableView
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kVideoDetailCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QFVideoDetailMaterialTextCell" bundle:nil] forCellReuseIdentifier:kVideoDetailTextCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QFVideoDetailMaterialImageCell" bundle:nil] forCellReuseIdentifier:kVideoDetailImageCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QFVideoDetailStepCell" bundle:nil] forCellReuseIdentifier:kVideoDetailStepCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QFVideoDetailKnowledgeCell" bundle:nil] forCellReuseIdentifier:kVideoDetailKnowledgeCell];
    
    [_tableView registerNib:[UINib nibWithNibName:@"QFVegetableVideoDetailHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:kVideoDetailHeader];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 评论
    _commnetsView = [QFVegetableVideoDetailCommentsView commentsView];
    _tableView.tableFooterView = _commnetsView;
    
    // 图片
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:_vegetable.imagePathThumbnails]];
}

- (void)initVideoPlayer
{
    self.videoPlayerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_vegetable.materialVideoPath]];
    self.videoPlayerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    
    self.videoPlayerController.controlStyle = MPMovieControlStyleEmbedded;
    self.videoPlayerController.shouldAutoplay = NO;
    self.videoPlayerController.repeatMode = MPMovieRepeatModeNone;
    self.videoPlayerController.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.playView insertSubview:self.videoPlayerController.view belowSubview:self.videoLoadingIndicator];
    
    // 播放状态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStateDidChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPlaybackDidEnd:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerIsReady:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidExitFullScreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
}

- (void)initData
{
    _dataSourceKeys = @[@"1", @"2", @"4", @"3"];
    _dataSource = [[NSMutableDictionary alloc] init];
    
    _sectionHeaderDataSource = [[NSMutableDictionary alloc] initWithDictionary:
                                @{@"1": @{@"title": @"所需材料", @"image": @"detail_material"},
                                  @"2": @{@"title": @"制作步骤", @"image": @"detail_step"},
                                  @"4": @{@"title": @"相关常识", @"image": @"detail_knowledge"},
                                  @"3": @{@"title": @"相宜相克", @"image": @"detail_suitable"}                                  }];
    
    _showSectionHeaderFlags = [[NSMutableDictionary alloc] initWithDictionary:
                               @{@"1": @NO,
                                 @"2": @NO,
                                 @"3": @NO,
                                 @"4": @NO}];
}

- (void)loadDataFromNetwork
{
    if (_commentLoadingIndicator.hidden == NO) {
        [_commentLoadingIndicator startAnimating];
    }
    
    // 创建分组
    dispatch_group_t group = dispatch_group_create();
    
    
    // 下载对应信息数据
    for (int i=0; i<_dataSourceKeys.count; i++) {
        
        dispatch_group_enter(group);
        
        NSString *key = _dataSourceKeys[i];
        NSLog(@"%@",key);
        NSDictionary *params = @{@"vegetable_id": _vegetable.vegetable_id,
                                 @"type": key,
                                 @"phonetype": @"0",
                                 @"is_traditional": @"0"};
        
        [AFHTTPRequestOperationManager GETRequest:URL_VEGETABLE_DETAIL parameters:params success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {
            
            if ([result.status isEqualToString:@"0"]) {
                [_dataSource setObject:result.data forKey:key];
            }
            else {
                [DPRemind simpleRemindMessage:result.message];
            }
            
            dispatch_group_leave(group);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
            
            dispatch_group_leave(group);
        }];
    }

    
    // 下载评论数据
    NSDictionary *params = @{@"vegetableId": _vegetable.vegetable_id,
                             @"page": @"1",
                             @"is_traditional": @"0"};
    
    dispatch_group_enter(group);
    
    [AFHTTPRequestOperationManager GETRequest:URL_VEGETABLE_COMMENTS parameters:params success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {
        dispatch_group_leave(group);
        
        if ([result.status isEqualToString:@"0"]) {
            [_commnetsView refreshWithData:result.data];
        }
        else {
            [DPRemind simpleRemindMessage:result.message];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_group_leave(group);
        
        NSLog(@"%@", error);
    }];
    
    
#if 0
//    // 下载当前菜谱相应数据
//    NSDictionary *params2 = @{@"vegetable_id": _vegetable.vegetable_id,
//                             @"user_id": @"",
//                             @"phonetype": @"2",
//                             @"is_traditional": @"0"};
//    
//    dispatch_group_enter(group);
//    
//    [AFHTTPRequestOperationManager GETRequest:URL_VEGETABLE_DETAIL_INFO parameters:params2 success:^(AFHTTPRequestOperation *operation, QFPKHTTPResponseResult *result) {
//        dispatch_group_leave(group);
//        
//        if ([result.status isEqualToString:@"0"]) {
//            QFVegetablePrototype *vegetable = [QFVegetablePrototype vegetableWithData:[result.data lastObject]];
//            NSLog(@"%@", vegetable);
//            NSLog(@"%@", _vegetable);
//        }
//        else {
//            [DPRemind simpleRemindMessage:result.message];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        dispatch_group_leave(group);
//        
//        NSLog(@"%@", error);
//    }];
#endif

    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if (_commentLoadingIndicator.isAnimating == YES) {
            [_commentLoadingIndicator stopAnimating];
            _commentLoadingIndicator.hidden = YES;
            
            _tableView.hidden = NO;
        }
        
        [_tableView reloadData];
    });
}


#pragma mark - Event Handlers


- (void)backBBIDidClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)playIconDidTap:(id)sender {
    
    self.playView.hidden = NO;
    self.playIcon.hidden = YES;
    
    if (self.videoPlayerController.readyForDisplay == YES) {
        [self.videoLoadingIndicator stopAnimating];
        [self.videoLoadingIndicator setHidden:YES];
    }
    else {
        [self.videoLoadingIndicator setHidden:NO];
        [self.videoLoadingIndicator startAnimating];
    }

    [self.videoPlayerController play];
}

- (IBAction)collectDidTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)cacheDidTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)shareDidTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)commentBtnDidClicked:(id)sender {
    [self.view endEditing:YES];
}

- (void)sectionHeaderDidTap:(UITapGestureRecognizer *)tapGesture
{
    QFVegetableVideoDetailHeader *header = (QFVegetableVideoDetailHeader *)tapGesture.view;
    NSString *sectionKey = _dataSourceKeys[header.section];
    BOOL showSection = [_showSectionHeaderFlags[sectionKey] boolValue];

    [_showSectionHeaderFlags setObject:@(!showSection) forKey:sectionKey];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:header.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QFVegetableVideoDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kVideoDetailHeader];
    header.section = section;
    if (!header.tapGesture) {
        header.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderDidTap:)];
    }
    
    NSString *sectionKey = _dataSourceKeys[section];
    BOOL showSection = [_showSectionHeaderFlags[sectionKey] boolValue];
    
    NSDictionary *sectionHeaderItem = _sectionHeaderDataSource[sectionKey];
    
    header.titleLabel.text = sectionHeaderItem[@"title"];
    
    NSString *imageName = sectionHeaderItem[@"image"];
    if (showSection) {
        header.backgroundImageView.image = [UIImage imageNamed:[imageName stringByAppendingString:@"_hl"]];
    }
    else {
        header.backgroundImageView.image = [UIImage imageNamed:imageName];
    }
    
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionKey = _dataSourceKeys[section];
    id data = _dataSource[sectionKey];
    BOOL showSection = [_showSectionHeaderFlags[sectionKey] boolValue];
    
    if (showSection) {
        
        switch (section) {
            case 0: {
                return [[[data lastObject] objectForKey:@"TblSeasoning"] count] + 3;
            }break;
            case 1: {
                return [data count];
            } break;
            case 2: {
                return 1;
            } break;
            case 3: {
                return 0;
            } break;
            default:
                return 0;
                break;
        }
    }
    else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    return [_vegetable.fittingRestriction sizeToFitFont:[UIFont systemFontOfSize:15] max:CGSizeMake(SCREEN_WIDTH-75, MAXFLOAT)].height + 22;
                } break;
                case 2: {
                    return [_vegetable.method sizeToFitFont:[UIFont systemFontOfSize:15] max:CGSizeMake(SCREEN_WIDTH-75, MAXFLOAT)].height + 22;
                } break;
                default:
                    return 200;
                    break;
            }
        } break;
            
        case 1: {
            return 200;
        } break;
        case 2: {
            return 457;
        }
        default: {
            return 30;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *sectionKey = _dataSourceKeys[indexPath.section];
    id data = _dataSource[sectionKey];
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0:
                {
                    QFVideoDetailMaterialTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:kVideoDetailTextCell forIndexPath:indexPath];
                    textCell.titleLabel.text = @"原料：";
                    textCell.descriptionLabel.text = _vegetable.fittingRestriction;
                    cell = textCell;
                }
                    break;
                case 2:
                {
                    QFVideoDetailMaterialTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:kVideoDetailTextCell forIndexPath:indexPath];
                    textCell.titleLabel.text = @"调料：";
                    textCell.descriptionLabel.text = _vegetable.method;
                    cell = textCell;
                }
                    break;
                default:
                {
                    QFVideoDetailMaterialImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kVideoDetailImageCell forIndexPath:indexPath];
                    
                    NSString *imagePath = nil;
                    if (indexPath.row == 1) {
                        imagePath = [[data lastObject] objectForKey:@"imagePath"];
                    }
                    else {
                        imagePath = [[[[data lastObject] objectForKey:@"TblSeasoning"] objectAtIndex:indexPath.row-3] objectForKey:@"imagePath"];
                    }
                    
                    [imageCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
                    cell = imageCell;
                }
                    break;
            }
        } break;
        case 1: {
            QFVideoDetailStepCell *stepCell = [tableView dequeueReusableCellWithIdentifier:kVideoDetailStepCell forIndexPath:indexPath];
            id dataItem = [data objectAtIndex:indexPath.row];

            [stepCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:[dataItem objectForKey:@"imagePath"]]];
            stepCell.descriptionLabel.text = [dataItem objectForKey:@"describe"];
            stepCell.stepLabel.text = [dataItem objectForKey:@"order_id"];
            
            stepCell.backgroundColor = [UIColor clearColor];
            return stepCell;
        } break;
        case 2: {
            QFVideoDetailKnowledgeCell *konwledgeCell = [tableView dequeueReusableCellWithIdentifier:kVideoDetailKnowledgeCell forIndexPath:indexPath];
            id dataItem = [data lastObject];

            [konwledgeCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:[dataItem objectForKey:@"imagePath"]]];;
            konwledgeCell.descriptionLabel.text = [dataItem objectForKey:@"nutritionAnalysis"];
            konwledgeCell.guideLabel.text = [dataItem objectForKey:@"productionDirection"];
            
            cell = konwledgeCell;
        } break;
        case 3: {
            
        } break;
        default: {
            
            cell = [tableView dequeueReusableCellWithIdentifier:kVideoDetailCell forIndexPath:indexPath];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    NSLog(@"%@", _dataSource);
    
    return cell;
}


#pragma mark - Notification


- (void)playerStateDidChanged:(NSNotification *)notification
{
    switch (_videoPlayerController.playbackState) {
        case MPMoviePlaybackStatePlaying:{
            if (self.playIcon.hidden == NO) {
                self.playIcon.hidden = YES;
            }
        }
            break;
        case MPMoviePlaybackStatePaused:
        {
            if (self.playIcon.hidden == YES) {
                self.playIcon.hidden = NO;
            }
        }
            break;
        default:
            break;
    }
}

- (void)playerPlaybackDidEnd:(NSNotification *)notification
{
    self.playIcon.hidden = NO;
}

- (void)playerIsReady:(NSNotification *)notification
{
    [self.videoLoadingIndicator stopAnimating];
    self.videoLoadingIndicator.hidden = YES;
}

- (void)playerWillEnterFullScreen:(NSNotification *)notification
{
    // 转成橫屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
    
    self.playViewHeightContraint.constant = 0;
}

- (void)playerWillExitFullScreen:(NSNotification *)notification
{
    // 退出播放转成竖屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}

- (void)playerDidExitFullScreen:(NSNotification *)notification
{
    self.playViewHeightContraint.constant = 220;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat dureation = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];

    [UIView animateWithDuration:dureation animations:^{
        self.inputViewBottomConstraint.constant = keyboardHeight;
        self.topConstraint.constant = 64 - keyboardHeight;
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat dureation = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:dureation animations:^{
        self.inputViewBottomConstraint.constant = 0;
        self.topConstraint.constant = 64;
        [self.view layoutIfNeeded];
    } completion:nil];
}

@end
