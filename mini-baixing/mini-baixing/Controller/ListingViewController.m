//
//  ListingViewController.m
//  mini-baixing
//
//  Created by zengming on 6/4/13.
//  Copyright (c) 2013 baixing.com. All rights reserved.
//

#import "ListingViewController.h"
#import <BXAdParams.h>
#import "ViewadViewController.h"
#import <BCConfig/BXConfig.h>
#import <UIImageView+WebCache.h>

@interface ListingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *          tableView;
@property (strong, nonatomic) IBOutlet UIButton *           loadMoreButton;

@property (strong, nonatomic) NSMutableArray *              adsData;
@property (strong, nonatomic) BXAdParams *                  adParams;

@end

@implementation ListingViewController

- (void)loadView
{
    [super loadView];
    
    self.adsData = [NSMutableArray array];
    self.adParams = [BXAdParams instanceWithQuery:
                     @{@"categoryEnglishName": _category.englishName ?: @"",
                     @"cityEnglishName" : [[[BXConfig sharedInstance] currentCity] englishName],
                     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _category.name;
    self.bxNavigationWrapView.rightView = [[BXBarButton alloc] initWithTitle:@"刷新"
                                                                      target:self
                                                                      action:@selector(reloadAdsButtonAction)];
    [self loadAds];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _adsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * listingCellId = @"listingCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listingCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listingCellId];
    }
    BXAd *ad = _adsData[indexPath.row];
    cell.textLabel.text = ad.title;
    cell.detailTextLabel.text = ad.formatCreatedTime;
    if (ad.imageFlag) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:ad.resize180Images[0]]
                       placeholderImage:[UIImage imageNamed:@"114"]];
    } else {
        cell.imageView.image = nil;
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BXAd *ad = _adsData[indexPath.row];
    ViewadViewController *viewad = [[ViewadViewController alloc] initWithNibName:@"ViewadViewController" bundle:nil];
    viewad.ad = ad;
    [self.bxNavigationController pushViewController:viewad animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}

#pragma mark- private

- (IBAction)loadMoreAction {
    _adParams.start = _adsData.count;
    [self loadAds];
}

- (void)reloadAdsButtonAction
{
    _adParams.start = 0;
    [_adsData removeAllObjects];
    [self customTableViewReloadData];
    [self loadAds];
}

- (void)loadAds
{
    [self toastLoadingMessage:@"加载中"];
    [[BXAdProvider sharedInstance] getAdsWithBXAdParams:_adParams onSuccess:^(NSArray *responseArray, int totalCount)
     {
         [self toastHide];
         [_adsData addObjectsFromArray:responseArray];
         [self customTableViewReloadData];
     } onFailure:^(BXError *err) {
         [self toastErrorMessage:@"加载失败"];
     }];
}

- (void)customTableViewReloadData
{
    self.tableView.tableFooterView = _adsData.count > 0 ? _loadMoreButton : nil;
    [self.tableView reloadData];
}

@end
