//
//  TLMMyTableViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/18/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMMyTableViewController.h"
#import "TLMGlobal.h"
#import "AppDelegate.h"

@interface TLMMyTableViewController ()

@end

@implementation TLMMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237/255.0 green:127/255.0 blue:74/255.0 alpha:1.0];
    
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2.0;
    self.headImageView.clipsToBounds = YES;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidAppear:(BOOL)animated {
    self.nickNameLabel.text = [TLMGlobal shareGlobal].user.username;
    self.headImageView.image = [TLMGlobal shareGlobal].user.image;
    self.emailLabel.text = [TLMGlobal shareGlobal].user.email;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat header;
    if (section == 0) {
        header = 13.0;
    } else if (section == 1) {
        header = 10;
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"nickname"];
            cell.textLabel.text = @"更改昵称";
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"headimage"];
            cell.textLabel.text = @"设置头像";
        } else if (indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"signout"];
            cell.textLabel.text = @"注销登录";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"rate"];
            cell.textLabel.text = @"评价我们";
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"followus"];
            cell.textLabel.text = @"关注我们";
        } else if (indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"homepage"];
            cell.textLabel.text = @"官方网站";
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0)&&(indexPath.row == 2)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定注销吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
            [TLMGlobal shareGlobal].user = nil;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate loadLoginView];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:enterAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
