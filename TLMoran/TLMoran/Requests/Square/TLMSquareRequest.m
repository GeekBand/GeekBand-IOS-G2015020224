//
//  TLMSquareRequest.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMSquareRequest.h"
#import "TLMSquareRequestParser.h"

@implementation TLMSquareRequest

- (void)sendSquareRequestWithParameter:(NSDictionary *)paramDic delegate:(id<TLMSquareRequestDelegate>)delegate {
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/node/list?distance=%@&latitude=%@&longitude=%@&token=%@&user_id=%@", paramDic[@"distance"], paramDic[@"latitude"], paramDic[@"longitude"], paramDic[@"token"], paramDic[@"user_id"]];
    
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSLog(@"url = %@", url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *string =[[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Square receive data string: %@", string);
    
    TLMSquareRequestParser *parser = [[TLMSquareRequestParser alloc] init];
    if ([_delegate respondsToSelector:@selector(squareRequestSuccess:dictionary:)]) {
        [_delegate squareRequestSuccess:self dictionary:[parser parseJson:self.receivedData]];
        NSLog(@"parse success");
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(squareRequestFailed:error:)]) {
        [_delegate squareRequestFailed:self error:error];
    }
}

@end
