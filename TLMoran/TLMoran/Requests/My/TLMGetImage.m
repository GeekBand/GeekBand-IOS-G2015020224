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
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString, [TLMGlobal shareGlobal].user.userId];
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [TLMGlobal shareGlobal].user.image = [UIImage imageWithData:data];
}


@end
