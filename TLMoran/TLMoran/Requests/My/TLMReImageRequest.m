//
//  TLMReImageRequest.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMReImageRequest.h"
#import "BLMultipartForm.h"
#import "TLMGlobal.h"

@implementation TLMReImageRequest

- (void)sendReImageRequestWithImage:(UIImage *)image delegate:(id<TLMReImageRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/avatar";
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:[TLMGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[TLMGlobal shareGlobal].user.token forField:@"token"];
    
    NSData *data;
    data = UIImageJPEGRepresentation(image, 0.000001);
    
    //NSLog(@"将上传的 image: %@", image);
    //NSLog(@"将上传的 data: %@", data);
    
    [form addValue:data forField:@"data"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"ReImage data string: %@", string);
    if ([_delegate respondsToSelector:@selector(reImageRequestSuccess:)]) {
        [_delegate reImageRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(reImageRequestFail:error:)]) {
        [_delegate reImageRequestFail:self error:error];
    }
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    NSLog(@"bytesWritten: %ld", (long)bytesWritten);
    NSLog(@"totalWritten: %ld", (long)totalBytesWritten);
    NSLog(@"totalBytesExpectedToWrite: %ld", totalBytesWritten);
}

@end
