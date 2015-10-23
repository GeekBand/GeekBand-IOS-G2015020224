//
//  TLMLoginRequestParser.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/13/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMLoginRequestParser.h"

@implementation TLMLoginRequestParser

- (TLMUserModel *)parseJson:(NSData *)data;
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"The parser is not working");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass: [NSString class]]) {
                TLMUserModel *user = [[TLMUserModel alloc] init];
                user.loginReturnMessage = returnMessage;
                id data = [jsonDic valueForKey:@"data"];
                if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                    id userId = [data valueForKey:@"user_id"];
                    if ([[userId class] isSubclassOfClass:[NSString class]]) {
                        user.userId = userId;
                    }
                    id token = [data valueForKey:@"token"];
                    if ([[token class] isSubclassOfClass:[NSString class]]) {
                        user.token = token;
                    }
                    id userName = [data valueForKey:@"user_name"];
                    if ([[userName class] isSubclassOfClass:[NSString class]]) {
                        user.username = userName;
                    }
                }
                return user;
            }
        }
    }
    return nil;
}

@end
