//
//  TLMRegisterRequestParser.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/14/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMRegisterRequestParser.h"

@implementation TLMRegisterRequestParser

- (TLMUserModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"The parser is not working");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                TLMUserModel *user = [[TLMUserModel alloc] init];
                user.registerReturnMessage = returnMessage;
                
                return user;
            }
        }
    }
    return nil;
}

@end
