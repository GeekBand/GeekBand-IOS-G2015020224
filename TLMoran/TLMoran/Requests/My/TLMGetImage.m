//
//  TLMGetImage.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMGetImage.h"
#import "TLMGlobal.h"

@implementation TLMGetImage

- (void)sendGetImageRequest {
    [self.urlConnection cancel];
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString, [TLMGlobal shareGlobal].user.userId];
    
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.receivedData = [NSMutableData data];
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   // NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    //NSLog(@"get image data:%@", string);
    
    [TLMGlobal shareGlobal].user.image = [UIImage imageWithData:self.receivedData];
    NSLog(@"receivedData: %@", self.receivedData);
    NSLog(@"user: %@", [TLMGlobal shareGlobal].user);
    NSLog(@"generate image: %@", [UIImage imageWithData:self.receivedData]);
    NSLog(@"user image: %@", [TLMGlobal shareGlobal].user.image);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"getImage error = %@", error);
}

@end
