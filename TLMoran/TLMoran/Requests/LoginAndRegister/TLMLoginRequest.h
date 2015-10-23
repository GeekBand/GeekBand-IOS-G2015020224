//
//  TLMLoginRequest.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/13/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMUserModel.h"

@class TLMLoginRequest;

@protocol TLMLoginRequestDelegate <NSObject>

- (void)loginRequestSuccess:(TLMLoginRequest *)request user:(TLMUserModel *)user;
- (void)loginRequestFailed:(TLMLoginRequest *)request error:(NSError *)error;

@end

@interface TLMLoginRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <TLMLoginRequestDelegate> delegate;

- (void)sendLoginRequestWithEmail:(NSString *)email
                         password:(NSString *)password
                             gbid:(NSString *)gbid
                         delegate:(id <TLMLoginRequestDelegate>)delegate;

@end
