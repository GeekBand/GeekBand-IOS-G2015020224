//
//  AppDelegate.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/12/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)loadMainViewWithController:(UIViewController *)controller;
- (void)loadLoginView;

@end

