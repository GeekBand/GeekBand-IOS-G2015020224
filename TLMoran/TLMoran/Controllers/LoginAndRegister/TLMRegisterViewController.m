//
//  TLMRegisterViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/14/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMRegisterViewController.h"
#import "TLMRegisterRequest.h"


@interface TLMRegisterViewController () <TLMRegisterRequestDelegate>

@property (nonatomic, strong) TLMRegisterRequest *registerRequest;

@end

@implementation TLMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerButton.layer.cornerRadius = 5.0;
    self.registerButton.clipsToBounds = YES;
    
    self.userNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.repeatPasswordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

- (IBAction)touchDownAction:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect frame = self.registerButton.frame;
    int offset = frame.origin.y + 36 - (self.view.frame.size.height - 266);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if (offset > 0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

#pragma mark - Check TexField Input

- (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL) isValidatePassword:(NSString *)password {
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordPredicate evaluateWithObject:password];
}

#pragma mark - Custom Event Methods

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerButtonClicked:(id)sender {
    NSString *username = self.userNameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *repeatPassword = self.repeatPasswordTextField.text;
    
    if (([username length] == 0) ||
        ([email length] == 0) ||
        ([password length] == 0) ||
        ([repeatPassword length] == 0)) {
        [self showErrorMessage:@"用户名、邮箱和密码不能为空"];
    } else if (![self isValidateEmail:email]) {
        [self showErrorMessage:@"邮箱格式错误"];
    } else if (![password isEqualToString:repeatPassword]) {
        [self showErrorMessage:@"您两次输入的密码不一致"];
    } else if (![self isValidatePassword:password]) {
        [self showErrorMessage:@"密码格式有误，应为6~20位的字母或数字"];
    } else {
        [self registerHandle];
    }
}

- (void) showErrorMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)registerHandle {
    NSString *username = self.userNameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"GeekBand-I150001";
    
    self.registerRequest = [[TLMRegisterRequest alloc] init];
    [self.registerRequest sendRegisterRequestWithUserName:username email:email password:password gbid:gbid delegate:self];
}

#pragma mark - TLMRegisterRequestDelegate methods

- (void) registerRequestSuccess:(TLMRegisterRequest *)request user:(TLMUserModel *)user {
    if ([user.registerReturnMessage isEqualToString:@"Register success"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"注册成功，请登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)registerRequestFailed:(TLMRegisterRequest *)request error:(NSError *)error {
    NSLog(@"注册错误原因：%@", error);
}

@end
