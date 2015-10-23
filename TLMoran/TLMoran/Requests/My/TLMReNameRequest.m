//
//  TLMReNameRequest.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/22/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMReNameRequest.h"
#import "BLMultipartForm.h"
#import "TLMGlobal.h"

@implementation TLMReNameRequest

- (void)sendRenameRequestWithName:(NSString *)name delegate:(id <TLMReNameRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/rename";
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:[TLMGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[TLMGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:name forField:@"new_name"];
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
    NSLog(@"Rename data string: %@", string);
    if ([_delegate respondsToSelector:@selector(renameRequestSuccess:)]) {
        [_delegate renameRequestSuccess:self];
    }
    
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(renameRequestFail:error:)]) {
        [_delegate renameRequestFail:self error:error]; 
    }
}

@end
