//
//  TLMLoginViewController.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/12/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLMLoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;

@end
