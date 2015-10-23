//
//  TLMNickNameViewController.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMReNameRequest.h"

@interface TLMNickNameViewController : UIViewController <TLMReNameRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) NSString *nickName;

- (IBAction)doneButtonClicked:(id)sender;

@end
