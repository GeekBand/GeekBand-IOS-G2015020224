//
//  TLMRegisterViewController.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/14/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMLoginRequest.h"


@interface TLMRegisterViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)touchDownAction:(id)sender;
- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)registerButtonClicked:(id)sender;

@end
