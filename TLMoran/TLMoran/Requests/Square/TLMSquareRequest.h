//
//  TLMSquareRequest.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMSquareModel.h"

@class TLMSquareRequest;

@protocol TLMSquareRequestDelegate <NSObject>

- (void)squareRequestSuccess:(TLMSquareRequest *)request dictionary:(NSDictionary *)dictionary;
//- (void)squareRequestSuccess:(TLMSquareRequest *)request squareModel:(TLMSquareModel *)squareModel;
- (void)squareRequestFailed:(TLMSquareRequest *)request error:(NSError *)error;

@end

@interface TLMSquareRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData  *receivedData;
@property (nonatomic, assign) id <TLMSquareRequestDelegate> delegate;

- (void)sendSquareRequestWithParameter:(NSDictionary *)paramDic
                              delegate:(id <TLMSquareRequestDelegate>)delegate;

@end
