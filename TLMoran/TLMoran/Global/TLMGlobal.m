//
//  TLMGlobal.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/18/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMGlobal.h"

static TLMGlobal *global = nil;

@implementation TLMGlobal

+ (TLMGlobal *)shareGlobal {
    if (global == nil) {
        global = [[TLMGlobal alloc] init];
    }
    return global;
}

@end
