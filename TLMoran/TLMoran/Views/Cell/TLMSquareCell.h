//
//  TLMSquareCell.h
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMSquareViewController.h"

@interface TLMSquareCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) TLMSquareViewController *squareVC;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
