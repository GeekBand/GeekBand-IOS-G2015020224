//
//  TLMSquareRequestParser.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMSquareRequestParser.h"

@implementation TLMSquareRequestParser

- (NSDictionary *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (error) {
        NSLog(@"The parser is not working");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id data = [[jsonDic valueForKey:@"data"] allValues];
            for (id dic in data) {
                self.addrArray = [NSMutableArray array];
                self.pictureArray = [NSMutableArray array];
                TLMSquareModel *squareModel = [[TLMSquareModel alloc] init];
                [squareModel setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDictionary in dic[@"pic"]) {
                    TLMPictureModel *pictureModel = [[TLMPictureModel alloc] init];
                    [pictureModel setValuesForKeysWithDictionary:picDictionary];
                    [self.pictureArray addObject:pictureModel];
                }
                
                [self.addrArray addObject:squareModel];
                [dictionary setObject:_pictureArray forKey:_addrArray];
            }
        }
    }
    NSLog(@"parsed out dictionary %@", dictionary);
    return dictionary;
}

@end
