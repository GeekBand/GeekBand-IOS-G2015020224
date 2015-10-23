//
//  AppDelegate.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/12/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "AppDelegate.h"
#import "TLMMyTableViewController.h"
#import "TLMLoginViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) TLMLoginViewController *loginViewController;

@end

@implementation AppDelegate

- (void)loadMainViewWithController:(UIViewController *)controller {
    UIViewController *squareVC = [[UIViewController alloc] init];
    squareVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:squareVC];
    nav1.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    
    nav1.tabBarItem.title = @"广场";
    nav1.tabBarItem.image = [UIImage imageNamed:@"square"];
    
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"TLMMy" bundle:[NSBundle mainBundle]];
    //TLMMyTableViewController *myVC = [[TLMMyTableViewController alloc] init];
    UINavigationController *nav2 = [myStoryboard instantiateViewControllerWithIdentifier:@"MyStoryboard"];
    
    nav2.tabBarItem.title = @"我的";
    nav2.tabBarItem.image = [UIImage imageNamed:@"my"];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav1, nav2];
    
    [controller presentViewController:self.tabBarController animated:YES completion:nil];
    [UIView animateWithDuration:0.3
                     animations:^{self.loginViewController.view.alpha = 0.5;}
                     completion:^(BOOL finished) {self.loginViewController = nil;}
     ];
    
    UIButton *photoButton = [[UIButton alloc] initWithFrame:CGRectMake(controller.view.frame.size.width/2-60, -25, 120, 50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    //[photoButton addTarget:self action:@selector(addOrderView) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
    
}

- (void)loadLoginView {
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
