//
//  TLMRegisterRequestParser.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/14/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMUserModel.h"

@interface TLMRegisterRequestParser : NSObject

- (TLMUserModel *)parseJson:(NSData *)data;

@end
