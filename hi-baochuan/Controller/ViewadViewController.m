//
//  ViewadViewController.m
//  mini-baixing
//
//  Created by zengming on 6/4/13.
//  Copyright (c) 2013 baixing.com. All rights reserved.
//

#import "ViewadViewController.h"
#import <MWPhotoBrowser.h>

@interface ViewadViewController () <MWPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@end

@implementation ViewadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableString *meta = [NSMutableString string];
    [_ad.metaData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [meta appendFormat:@"%@\n", obj];
    }];
    NSString *content = [NSString stringWithFormat:@"%@\n\n%@\n\n%@", _ad.title, meta, _ad.desc];
    
    self.textView.text = content;
    self.title = _ad.formatCreatedTime;
    if (_ad.mobile.length > 0) {
        [self.phoneButton setTitle:_ad.mobile forState:UIControlStateNormal];
    } else {
        self.phoneButton.enabled = NO;
        [self.phoneButton setTitle:@"无手机号" forState:UIControlStateNormal];
    }
    
    if (_ad.imageFlag) {
        NSString *imageBtnTitle = [NSString stringWithFormat:@"图片 %d 张", _ad.bigImages.count];
        self.bxNavigationWrapView.rightView = [[BXBarButton alloc] initWithTitle:imageBtnTitle
                                                                          target:self
                                                                          action:@selector(showBigImages)];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)phoneButtonClicked
{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _ad.mobile]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        [self toastErrorMessage:@"你的设备不支持拨打电话"];
    }
}

- (void)showBigImages
{
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:photoBrowser]
                       animated:YES
                     completion:nil];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _ad.bigImages.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return [[MWPhoto alloc] initWithURL:[NSURL URLWithString:_ad.bigImages[index]]];
}

@end
