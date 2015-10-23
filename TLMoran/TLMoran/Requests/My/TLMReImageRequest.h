//
//  TLMReImageRequest.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TLMReImageRequest;

@protocol TLMReImageRequestDelegate <NSObject>

- (void)reImageRequestSuccess:(TLMReImageRequest *)request;
- (void)reImageRequestFail:(TLMReImageRequest *)request error:(NSError *)error;

@end

@interface TLMReImageRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) id <TLMReImageRequestDelegate> delegate;

- (void)sendReImageRequestWithImage:(UIImage *)image delegate:(id <TLMReImageRequestDelegate>)delegate;

@end
