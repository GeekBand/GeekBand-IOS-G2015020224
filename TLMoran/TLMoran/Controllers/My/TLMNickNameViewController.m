//
//  TLMNickNameViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMNickNameViewController.h"
#import "TLMGlobal.h"

@interface TLMNickNameViewController ()

@end

@implementation TLMNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonClicked:(id)sender {
    TLMReNameRequest *reNameRequest = [[TLMReNameRequest alloc] init];
    [reNameRequest sendRenameRequestWithName:self.nickNameTextField.text delegate:self];
}

- (void)renameRequestSuccess:(TLMReNameRequest *)request {
    [TLMGlobal shareGlobal].user.username = self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)renameRequestFail:(TLMReNameRequest *)request error:(NSError *)error {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
