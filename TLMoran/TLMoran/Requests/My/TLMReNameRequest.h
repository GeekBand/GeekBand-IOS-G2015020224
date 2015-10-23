//
//  TLMReNameRequest.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMReNameRequest;

@protocol TLMReNameRequestDelegate <NSObject>

- (void)renameRequestSuccess:(TLMReNameRequest *)request;
- (void)renameRequestFail:(TLMReNameRequest *)request error:(NSError *)error;

@end

@interface TLMReNameRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id <TLMReNameRequestDelegate> delegate;

- (void)sendRenameRequestWithName:(NSString *)name delegate:(id <TLMReNameRequestDelegate>)delegate;

@end
