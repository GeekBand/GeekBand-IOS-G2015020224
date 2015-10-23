//
//  TLMHeadImageViewController.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMReImageRequest.h"

@interface TLMHeadImageViewController : UIViewController <TLMReImageRequestDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)addActionSheet:(id)sender;

@end
