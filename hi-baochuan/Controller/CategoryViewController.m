//
//  BXViewController.m
//  mini-baixing
//
//  Created by zengming on 6/3/13.
//  Copyright (c) 2013 baixing.com. All rights reserved.
//

#import "CategoryViewController.h"
#import "ListingViewController.h"

@interface CategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *      tableView;
@property (assign, nonatomic)   BOOL                    isFirstCategory;

@end

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _category.name ?: @"百姓网";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    if (!_category) {
        self.category = [[BXCategoryProvider sharedInstance] getRootCategory];
        self.isFirstCategory = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [_tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _category.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * categoryCellId = @"categoryCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:_isFirstCategory ? UITableViewCellStyleDefault : UITableViewCellStyleValue2
                                      reuseIdentifier:categoryCellId];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    BXCategory *cate = _category.children[indexPath.row];
    
    if (_isFirstCategory) {
        NSString *imageName = [NSString stringWithFormat:@"Home_Body_Icon_%@", cate.englishName];
        cell.imageView.image = [UIImage imageNamed:imageName];
        cell.textLabel.text = cate.name;
    } else {
        cell.textLabel.text = cate.englishName;
        cell.detailTextLabel.text = cate.name;
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BXCategory *cate = _category.children[indexPath.row];
    if (_isFirstCategory > 0) { // show second category
        CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
        categoryViewController.category = cate;
        [self.bxNavigationController pushViewController:categoryViewController animated:YES];
    } else { // show listing
        ListingViewController *listingViewController = [[ListingViewController alloc] initWithNibName:@"ListingViewController" bundle:nil];
        listingViewController.category = cate;
        [self.bxNavigationController pushViewController:listingViewController animated:YES];
    }
}

@end
