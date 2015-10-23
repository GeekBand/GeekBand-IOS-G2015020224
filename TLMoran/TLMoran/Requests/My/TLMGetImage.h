//
//  TLMGetImage.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMUserModel.h"

@interface TLMGetImage : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;

- (void)sendGetImageRequest;

@end
