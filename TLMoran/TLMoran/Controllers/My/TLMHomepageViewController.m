//
//  TLMHomepageViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/18/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMHomepageViewController.h"

@interface TLMHomepageViewController ()

@end

@implementation TLMHomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"http://geekband.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
