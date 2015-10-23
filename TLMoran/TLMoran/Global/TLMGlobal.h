//
//  TLMGlobal.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/18/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMUserModel.h"

@interface TLMGlobal : NSObject

@property (nonatomic, strong) TLMUserModel *user;

+ (TLMGlobal *)shareGlobal;

@end
