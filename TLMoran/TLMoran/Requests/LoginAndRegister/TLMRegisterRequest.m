//
//  TLMRegisterRequest.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/14/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMRegisterRequest.h"
#import "BLMultipartForm.h"
#import "TLMRegisterRequestParser.h"

@implementation TLMRegisterRequest
- (void)sendRegisterRequestWithUserName:(NSString *)username
                                  email:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid
                               delegate:(id<TLMRegisterRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/register";
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:username forField:@"username"];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
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
    NSLog(@"receive data string: %@", string);
    
    TLMRegisterRequestParser *parser = [[TLMRegisterRequestParser alloc] init];
    TLMUserModel *user = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(registerRequestSuccess:user:)]) {
        [_delegate registerRequestSuccess:self user:user];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(registerRequestFailed:error:)]) {
        [_delegate registerRequestFailed:self error:error];
    }
}

@end
