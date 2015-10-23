//
//  TLMLoginViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/12/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMLoginViewController.h"
#import "TLMUserModel.h"
#import "TLMLoginRequest.h"
#import "AppDelegate.h"
#import "TLMGlobal.h"
#import "TLMGetImage.h"

@interface TLMLoginViewController () <TLMLoginRequestDelegate>

@property (nonatomic, strong) TLMLoginRequest *loginRequest;

@end

@implementation TLMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom event methods

- (IBAction)loginButtonClicked:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (([email length] == 0) || ([password length] == 0)) {
        [self showErrorMessage:@"邮箱和密码不能为空"];
    } else {
        [self loginHandle];
    }
}

- (void)showErrorMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (void)loginHandle {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"GeekBand-I150001";
    
    self.loginRequest = [[TLMLoginRequest alloc] init];
    [self.loginRequest sendLoginRequestWithEmail:email
                                        password:password
                                            gbid:gbid
                                        delegate:self];
}

#pragma mark - TLMLoginRequestDelegate methods

- (void)loginRequestSuccess:(TLMLoginRequest *)request user:(TLMUserModel *)user
{
    if ([user.loginReturnMessage isEqualToString:@"Login success"]) {
        NSLog(@"登录成功，现在转换页面");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadMainViewWithController:self];
        [TLMGlobal shareGlobal].user = user;
        [TLMGlobal shareGlobal].user.email = self.emailTextField.text;
        TLMGetImage *getimage = [[TLMGetImage alloc] init];
        [getimage sendGetImageRequest];
        
    } else {
        NSLog(@"服务器报错：%@", user.loginReturnMessage);
    }
}

- (void)loginRequestFailed:(TLMLoginRequest *)request error:(NSError *)error
{
    NSLog(@"登录错误原因: %@", error);
}

#pragma mark - TextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
