//
//  TLMUserModel.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/13/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TLMUserModel : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *loginReturnMessage;
@property (nonatomic, copy) NSString *registerReturnMessage;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) UIImage *image;

@end
