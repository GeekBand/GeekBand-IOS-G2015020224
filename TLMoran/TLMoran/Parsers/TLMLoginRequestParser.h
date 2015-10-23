//
//  TLMLoginRequestParser.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/13/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMUserModel.h"

@interface TLMLoginRequestParser : NSObject

- (TLMUserModel *)parseJson:(NSData *)data;

@end
