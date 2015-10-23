//
//  TLMRegisterRequest.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/14/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMUserModel.h"

@class TLMRegisterRequest;

@protocol TLMRegisterRequestDelegate <NSObject>

- (void)registerRequestSuccess:(TLMRegisterRequest *)request user:(TLMUserModel *)user;
- (void)registerRequestFailed:(TLMRegisterRequest *)request error:(NSError *)error;

@end

@interface TLMRegisterRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id <TLMRegisterRequestDelegate> delegate;

- (void)sendRegisterRequestWithUserName:(NSString *)username
                                  email:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid
                               delegate:(id <TLMRegisterRequestDelegate>)delegate;

@end
