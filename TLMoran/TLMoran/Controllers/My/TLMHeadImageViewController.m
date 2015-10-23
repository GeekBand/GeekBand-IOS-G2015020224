//
//  TLMHeadImageViewController.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMHeadImageViewController.h"
#import "TLMGlobal.h"

@interface TLMHeadImageViewController ()

@end

@implementation TLMHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)doneButtonClicked:(id)sender {
    TLMReImageRequest *request = [[TLMReImageRequest alloc] init];
    [request sendReImageRequestWithImage:self.headImageView.image delegate:self];
}

- (IBAction)addActionSheet:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePicture = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Unable to get Camera" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [alert show];
        }
    }];
    UIAlertAction *choosePicture = [UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:takePicture];
    [alert addAction:choosePicture];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)reImageRequestSuccess:(TLMReImageRequest *)request {
    [TLMGlobal shareGlobal].user.image = self.headImageView.image;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reImageRequestFail:(TLMReImageRequest *)request error:(NSError *)error {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.headImageView.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
