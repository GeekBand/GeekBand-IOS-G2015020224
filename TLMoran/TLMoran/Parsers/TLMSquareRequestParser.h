//
//  TLMSquareRequestParser.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMSquareModel.h"
#import "TLMPictureModel.h"

@interface TLMSquareRequestParser : NSObject

@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSMutableArray *pictureArray;

- (NSDictionary *)parseJson:(NSData *)data;

@end
