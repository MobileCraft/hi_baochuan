//
//  BXAppDelegate.m
//  mini-baixing
//
//  Created by zengming on 6/3/13.
//  Copyright (c) 2013 baixing.com. All rights reserved.
//

#import "BXAppDelegate.h"

#import "CategoryViewController.h"

#define kApiKey         @""
#define kApiSecret      @""

#error please set api key

@implementation BXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[BXConfig sharedInstance] setApiKey:kApiKey];
    [[BXConfig sharedInstance] setApiSecret:kApiSecret];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    BXNavigationController *nav = [[BXNavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//#pragma mark - custom appearance
//- (void)customizeAppearance {
//    // Create resizable images
//    UIImage *gradientImage44 = [[UIImage imageNamed:@"Public_Header_Bg"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
//    
//    // Set the background image for *all* UINavigationBars
//    [[UINavigationBar appearance] setBackgroundImage:gradientImage44
//                                       forBarMetrics:UIBarMetricsDefault];
//    
//    //    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
//    
//    // Customize the title text for *all* UINavigationBars
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      kFontColorDark, UITextAttributeTextColor,
//      BXColor(0xff, 0xff, 0xff, 1), UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
//      //      [UIFont systemFontOfSize:kFontSizeLarge], UITextAttributeFont,
//      nil]];
//    
//    UIImage *buttonBack = [[UIImage imageNamed:@"Public_Header_Btn_Back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//    UIImage *buttonBackPress = [[UIImage imageNamed:@"Public_Header_Btn_Back_On.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBackPress
//                                                      forState:UIControlStateHighlighted
//                                                    barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -2)
//                                                         forBarMetrics:UIBarMetricsDefault];
//    
//    UIImage *barButton = [[UIImage imageNamed:@"Public_Header_Btn_Action.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//    UIImage *barButtonPress = [[UIImage imageNamed:@"Public_Header_Btn_Action_On.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//    [[UIBarButtonItem appearance] setBackgroundImage:barButton
//                                            forState:UIControlStateNormal
//                                          barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackgroundImage:barButtonPress
//                                            forState:UIControlStateHighlighted
//                                          barMetrics:UIBarMetricsDefault];
//    
//    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      kFontColorDark, UITextAttributeTextColor,
//      BXColor(0xff, 0xff, 0xff, 1), UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
//      [UIFont boldSystemFontOfSize:kFontSizeMedium], UITextAttributeFont,
//      nil]
//                                                forState:UIControlStateNormal];
//    
//    
//    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"Public_Header_Box_Search.png"] forState:UIControlStateNormal];
//    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"Public_Header_Icon_Search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//    
//    
//    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundImage:[[UIImage imageNamed:@"Public_Header_Btn_Action.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]
//                                                                                    forState:UIControlStateNormal
//                                                                                  barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundImage:[[UIImage imageNamed:@"Public_Header_Btn_Action_On.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]
//                                                                                    forState:UIControlStateHighlighted
//                                                                                  barMetrics:UIBarMetricsDefault];
//}

@end
